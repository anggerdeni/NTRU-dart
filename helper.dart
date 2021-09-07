import 'dart:math';
import 'polynomial.dart';

List<Polynomial> egcd(Polynomial a, Polynomial b, int p) {
  Polynomial d = a.reduce(p);
  Polynomial v1 = Polynomial.fromDegree(a.N, d: 0, coeff: 0);
  Polynomial v3 = b.reduce(p);
  Polynomial u = Polynomial.fromDegree(a.N, d: 0, coeff: 1);
  if(b.isZero()) {
    return [u, v1, d];
  }

  while(!v3.isZero()) {
    List<Polynomial> tmp = d.div(v3, p);
    Polynomial q = tmp[0].reduce(p);
    Polynomial t3 = tmp[1].reduce(p);
    if(t3.getDegree() >= v3.getDegree() && !t3.isZero()) throw new Exception('Something wrong');

    Polynomial t1 = (u - q * v1).reduce(p);
    u = v1.clone();
    d = v3.clone();
    v1 = t1.clone();
    v3 = t3.clone();
  }

  List<Polynomial> tmp = ((d - a * u).div(b, p));
  Polynomial v = tmp[0].reduce(p);
  Polynomial r = tmp[1].reduce(p);
  if(!r.isZero()) {
    // throw new Exception('Division not resulting in 0');
  };

  return [u, v, d];
}

Polynomial inverse(Polynomial a, int p) {
  Polynomial XN_1 = new Polynomial.fromDegree(a.N, d: a.N);
  XN_1.coefficients[0] = -1;
  List<Polynomial>tmp = egcd(a, XN_1, p);
  Polynomial u = tmp[0].reduce(p);
  Polynomial d = tmp[2].reduce(p);
  if(d.getDegree() == 0) {
    int dd = d.coefficients[0].modInverse(p);
    List<int> coeff = List.from(u.coefficients);
    for (int i = 0; i < coeff.length; i++) {
      coeff[i] *= dd;
    }
    return new Polynomial(a.N, coeff);
  }
  throw new Exception('No inverse found');
}

Polynomial generateRandomPolynomial(int N, { List<int>? options }) {
  List<int> coeff = List.filled(N, 0);
  if(options == null) {
    options = [-1,0,1];
  }
  Random rand = new Random();
  for (int i = 0; i < N; i++) {
    // randomize -1,0,1
    coeff[i] = options[rand.nextInt(options.length)];
  }

  return new Polynomial(N, coeff);
}