import 'helper.dart';
import 'polynomial.dart';

bool comparePoly(Polynomial a, Polynomial b) {
  for(int i = 0; i < a.N; i++) {
    if(a.coefficients[i] != b.coefficients[i]) return false;
  }
  return true;
}

void main() {
  // Polynomial a = generateRandomPolynomial(N);
  // List<int> coeffA = List.from(a.coefficients);
  // coeffA.add(0); // padding
  // a = new Polynomial(a.N+1, coeffA);
  // Polynomial XN_1 = new Polynomial.fromDegree(a.N, d: a.N-1);
  // XN_1.coefficients[0] = -1; // x^N - 1

  // print(a.div(XN_1, 3)[1].coefficients);

  // print(generateRandomPolynomial(10).coefficients);
  // print(generateRandomPolynomial2(10).coefficients);

  int p = 3;
  int q = 2048;
  int N = 10;
  for (int i = 0; i < 10000; i++) {
    Polynomial polynom1 = generateRandomPolynomial(10);
    Polynomial div = generateRandomPolynomial(10);
    List<Polynomial> result = polynom1.div(div, p);

    Polynomial t = (result[0] * div + result[1]).reduceCenterLift(p);
    if(!comparePoly(polynom1, t)) print('div failed');
  }
}