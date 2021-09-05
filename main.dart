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
  // if(!r.isZero()) {
  //   print('u ${u.coefficients}');
  //   print('v ${v.coefficients}');
  //   print('d ${d.coefficients}');
  //   print('r ${r.coefficients}');
  //   throw new Exception('Division not resulting in 0');
  // };

  return [u, v, d];
}

Polynomial inverse(Polynomial a, int p) {
  Polynomial XN_1 = new Polynomial.fromDegree(a.N, d: a.N);
  XN_1.coefficients[0] = -1;
  List<Polynomial>tmp = egcd(a, XN_1, p);
  Polynomial u = tmp[0].reduce(p);
  Polynomial v = tmp[1].reduce(p);
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

void main() {
  int p = 3;
  int q = 37;

  Polynomial polynom1 = Polynomial(11, [-1, 1, 1, 0, -1, 0, 1, 0, 0, 1, -1]).reduce(p);

  Polynomial invP = inverse(polynom1, p);
  Polynomial invQ = inverse(polynom1, q).reduce(q);
  polynom1 = Polynomial(10, [-1, 1, 1, 0, -1, 0, 1, 0, 0, 1, -1]).reduce(p);
  invP = Polynomial(10, invP.coefficients).reduce(p);
  invQ = Polynomial(10, invQ.coefficients).reduce(q);
  Polynomial testP = (invP * polynom1).reduce(p);
  Polynomial testQ = (invQ * polynom1).reduce(q);
  print(testP.coefficients);
  print(testQ.coefficients);
}