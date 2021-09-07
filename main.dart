import 'ntru.dart';

void main() {
  int p = 3;
  int q = 37;

  // NTRU ntru = new NTRU(347, p, q);
  NTRU ntru = new NTRU(10, p, q);
  print(ntru.publicKey.coefficients);

  // Polynomial polynom1 = Polynomial(11, [-1, 1, 1, 0, -1, 0, 1, 0, 0, 1, -1]).reduce(p);

  // Polynomial invP = inverse(polynom1, p);
  // Polynomial invQ = inverse(polynom1, q).reduce(q);
  // polynom1 = Polynomial(10, [-1, 1, 1, 0, -1, 0, 1, 0, 0, 1, -1]).reduce(p);
  // invP = Polynomial(10, invP.coefficients).reduce(p);
  // invQ = Polynomial(10, invQ.coefficients).reduce(q);
  // Polynomial testP = (invP * polynom1).reduce(p);
  // Polynomial testQ = (invQ * polynom1).reduce(q);
  // print(testP.coefficients);
  // print(testQ.coefficients);
  // Polynomial polynom1 = new Polynomial(1, [0]);
  // Polynomial invP = new Polynomial(1, [0]);
  // Polynomial invQ = new Polynomial(1, [0]);
  // Polynomial testP = new Polynomial(1, [0]);
  // Polynomial testQ = new Polynomial(1, [0]);

  // bool inverseFound = false;
  // int i = 1;
  // while(!inverseFound) {
  //   try {
  //     polynom1 = generateRandomPolynomial(11).reduce(p);
  //     invP = inverse(polynom1, p);
  //     invQ = inverse(polynom1, q).reduce(q);
  //     inverseFound = true;
  //   } catch(e) {
  //     i++;
  //     polynom1 = generateRandomPolynomial(11).reduce(p);
  //     continue;
  //   }
  // }
  // polynom1 = Polynomial(10, polynom1.coefficients.sublist(0,polynom1.coefficients.length - 1)).reduce(p);
  // invP = Polynomial(10, invP.coefficients).reduce(p);
  // invQ = Polynomial(10, invQ.coefficients).reduce(q);
  // testP = (invP * polynom1).reduce(p);
  // testQ = (invQ * polynom1).reduce(q);
  // print(testP.coefficients);
  // print(testQ.coefficients);
  // print(i);
}