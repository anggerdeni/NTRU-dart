import 'dart:math';
import 'polynomial.dart';

Polynomial mod2ToMod2048(Polynomial a, Polynomial Fq) {
  int v = 2;
  while (v < 2048) {
    v *= 2;
    Polynomial temp = Fq;
    temp = temp.multiplyInt(2).reduce(v);
    Fq = (a.multPoly(Fq, 2048)).multPoly(Fq, 2048);
    temp = temp.substractPoly(Fq, v);
    Fq = temp;
  }
  return Fq;
}

Polynomial inverseF2(Polynomial a) {
  List<int> coeffA = List.from(a.coefficients);
  coeffA.add(0); // padding
  a = new Polynomial(a.N+1, coeffA);
  int N = a.N-1;
  int k = 0;
  Polynomial b = Polynomial.fromDegree(N+1, d: 0);
  Polynomial c = Polynomial.fromDegree(N+1, d: 0, coeff: 0);
  Polynomial f = a;
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
      Polynomial temp = f;
      f = g;
      g = temp;
      // exchange b and c
      temp = b;
      b = c;
      c = temp;
    }
    f = f.addPolyMod2(g);
    b = b.addPolyMod2(c);
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

Polynomial inverseFq(Polynomial a) {
  Polynomial Fq = inverseF2(a);
  return mod2ToMod2048(a, Fq);
}

Polynomial inverseF3(Polynomial a) {
  List<int> coeffA = List.from(a.coefficients);
  coeffA.add(0); // padding
  a = new Polynomial(a.N+1, coeffA);
  int N = a.N-1;
  int k = 0;
  Polynomial b = Polynomial.fromDegree(N+1, d: 0);
  Polynomial c = Polynomial.fromDegree(N+1, d: 0, coeff: 0);
  Polynomial f = a;
  Polynomial g = new Polynomial.fromDegree(a.N, d: N);
  g.coefficients[0] = -1; // x^N - 1
  
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
      f = f.substractPolyMod3(g);
      b = b.substractPolyMod3(c);
    }
    else {
      f = f.addPolyMod3(g);
      b = b.addPolyMod3(c);
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

Polynomial generateRandomPolynomial2(int N, { List<int>? options }) {
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

Polynomial generateRandomPolynomial(int N) {
  List<int> coeff = randomCoefficients(N, (N/3).floor(), -1);
  return new Polynomial(N, coeff);
}

bool comparePoly(Polynomial a, Polynomial b) {
  for(int i = 0; i < a.N; i++) {
    if(a.coefficients[i] != b.coefficients[i]) return false;
  }
  return true;
}
