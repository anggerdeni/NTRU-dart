import 'dart:math';
import 'polynomial.dart';
import 'dart:convert';

List<Polynomial> egcd(Polynomial a, Polynomial b, int p) {
  Polynomial d = a.clone();
  Polynomial v1 = Polynomial.fromDegree(a.N, d: 0, coeff: 0);
  Polynomial v3 = b.clone();
  Polynomial u = Polynomial.fromDegree(a.N, d: 0, coeff: 1);
  if(b.isZero()) {
    return [u, v1, d];
  }

  while(!v3.isZero()) {
    List<Polynomial> tmp = d.div(v3, p);
    Polynomial q = tmp[0];
    Polynomial t3 = tmp[1];
    // if(t3.getDegree() > v3.getDegree()) throw new Exception('Something wrong');

    Polynomial t1 = u.substractPoly(q.multPoly(v1, p), p);
    u.coefficients = List.from(v1.coefficients);
    d.coefficients = List.from(v3.coefficients);
    v1.coefficients = List.from(t1.coefficients);
    v3.coefficients = List.from(t3.coefficients);
  }

  List<Polynomial> tmp = d.substractPoly(a.multPoly(u, p), p).div(b, p);
  Polynomial v = tmp[0];
  Polynomial r = tmp[1];
  if(!r.isZero()) {
    throw new Exception('Division not resulting in 0 ${r.coefficients}');
  };

  return [u, v, d];
}

List<int> mult2And(Polynomial a, int mask) {
  List<int> coeffs = List<int>.from(a.coefficients);
  int longMask = (mask<<24) + mask;
  for (int i=0; i < coeffs.length; i++) coeffs[i] = (coeffs[i]<<1) & longMask;
  return coeffs;
}

Polynomial mod2ToModq(Polynomial a, Polynomial Fq, int q) {
  if(q == 2048) {
    a = a;
    Fq = Fq;
    int v = 2;
    while (v < q) {
      v *= 2;
      Polynomial temp = Fq.clone();
      temp = temp.multiplyInt(2).reduce(v);
      Fq = (a.multPoly(Fq, 2048)).multPoly(Fq, 2048);
      temp = temp.substractPoly(Fq, v);
      Fq = temp.clone();
    }
    return Fq;
  } else {
    throw new Exception('q must be 2048');
  }
}

Polynomial inverseF2(Polynomial a) {
  List<int> coeffA = List.from(a.coefficients);
  coeffA.add(0); // padding
  a = new Polynomial(a.N+1, coeffA);
  int N = a.N-1;
  int k = 0;
  Polynomial b = Polynomial.fromDegree(N+1, d: 0);
  Polynomial c = Polynomial.fromDegree(N+1, d: N, coeff: 0);
  Polynomial f = a.clone();
  Polynomial g = new Polynomial.fromDegree(a.N, d: N);
  g.coefficients[0] = -1; // x^N - 1 what ? https://github.com/tbuktu/ntru/blob/78334321f544b9357e7417e935fb4b1a61264976/src/main/java/net/sf/ntru/polynomial/IntegerPolynomial.java#L410

  while(true) {
    while (f.coefficients[0] == 0) {
      /* f(x) = f(x) / x */
      for (int i = 1; i < f.N; i++) {
        f.coefficients[i-1] = f.coefficients[i];
      }
      f.coefficients[f.N-1] = 0;
      
      /* c(x) = c(x) * x */
      for (int i = c.N-1; i > 0; i--) {
        c.coefficients[i] = c.coefficients[i-1];
      }
      c.coefficients[0] = 0;

      k++;
      if (f.isZero()) throw new Exception('Not invertible 1');
    }
    if (f.isOne()) break;
    if (f.getDegree() < g.getDegree()) {
      // exchange f and g
      Polynomial temp = f.clone();
      f.coefficients = List<int>.from(g.coefficients);
      g.coefficients = List<int>.from(temp.coefficients);
      // exchange b and c
      temp = b.clone();
      b.coefficients = List<int>.from(c.coefficients);
      c.coefficients = List<int>.from(temp.coefficients);
    }
    f = f.addPoly(g, 2);
    b = b.addPoly(c, 2);
  }
  if (b.coefficients[N] != 0) {
    throw new Exception('Not invertible 2');
  }
  // Fq(x) = x^(N-k) * b(x)
  Polynomial Fq = Polynomial.fromDegree(N, d: 0, coeff: 0);
  int j = 0;
  k %= N;
  for (int i=N-1; i>=0; i--) {
    j = i - k;
    if (j < 0) j += N;
    Fq.coefficients[j] = b.coefficients[i];
  }
  return Fq;
}

Polynomial inverseFq(Polynomial a, int q) {
  Polynomial Fq = inverseF2(a);
  return mod2ToModq(a, Fq, q);
}

Polynomial inverseF3(Polynomial a) {
  List<int> coeffA = List.from(a.coefficients);
  coeffA.add(0); // padding
  a = new Polynomial(a.N+1, coeffA);
  int N = a.N-1;
  int k = 0;
  Polynomial b = Polynomial.fromDegree(N+1, d: 0);
  Polynomial c = Polynomial.fromDegree(N+1, d: N, coeff: 0);
  Polynomial f = a.clone();
  Polynomial g = new Polynomial.fromDegree(a.N, d: N);
  g.coefficients[0] = -1; // x^N - 1
  
  while(true) {
    Polynomial polymX = Polynomial.fromDegree(a.N, d: 1); 
    while (f.coefficients[0] == 0) {
      /* f(x) = f(x) / x */
      for (int i = 1; i < f.N; i++) {
        f.coefficients[i-1] = f.coefficients[i];
      }
      f.coefficients[f.N-1] = 0;
      
      /* c(x) = c(x) * x */
      for (int i = c.N-1; i > 0; i--) {
        c.coefficients[i] = c.coefficients[i-1];
      }
      c.coefficients[0] = 0;

      k++;
      if (f.isZero()) throw new Exception('Not invertible 3');
    }
    if (f.isOne()) break;
    if (f.getDegree() < g.getDegree()) {
      // exchange f and g
      Polynomial temp = f;
      f = g;
      g = temp;
      // exchange b and c
      temp = b;
      b = c;
      c = temp;
    }
    if (f.coefficients[0] == g.coefficients[0]) {
      f = f.substractPoly(g, 3);
      b = b.substractPoly(c, 3);
    }
    else {
      f = f.addPoly(g, 3);
      b = b.addPoly(c, 3);
    }
  }
  if (b.coefficients[N] != 0) {
    throw new Exception('Not invertible 4');
  }
  // Fp(x) = [+-] x^(N-k) * b(x)
  Polynomial Fp = Polynomial.fromDegree(N, d: 0, coeff: 0);
  int j = 0;
  k %= N;
  for (int i=N-1; i>=0; i--) {
    j = i - k;
    if (j < 0) j += N;
    Fp.coefficients[j] = (f.coefficients[0] * b.coefficients[i]) % 3;
  }
  return Fp;
}

List<int> randomCoefficients(int length, int d, int neg_ones_diff) {
  List<int> zeros = List.filled(length - 2*d - neg_ones_diff, 0);
  List<int> ones = List.filled(d, 1);
  List<int> neg_ones = List.filled(d + neg_ones_diff, -1);
  List<int> result = List.from(zeros)..addAll(ones)..addAll(neg_ones);
  result.shuffle();
  return result;
}

Polynomial generateRandomPolynomial(int N, { List<int>? options }) {
  List<int> coeff = List.filled(N, 0);
  if(options == null) {
    options = [-1,0,1];
  }
  Random rand = new Random();
  for (int i = 0; i < N; i++) {
    coeff[i] = options[rand.nextInt(options.length)];
  }

  return new Polynomial(N, coeff);
}

Polynomial generateRandomPolynomial2(int N) {
  List<int> coeff = randomCoefficients(N, (N/3).floor(), -1);
  return new Polynomial(N, coeff);
}

bool comparePoly(Polynomial a, Polynomial b) {
  for(int i = 0; i < a.N; i++) {
    if(a.coefficients[i] != b.coefficients[i]) return false;
  }
  return true;
}

List<int> str2byteArray(String x) {
  return utf8.encode(x);
}

