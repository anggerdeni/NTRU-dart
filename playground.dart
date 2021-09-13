import 'polynomial.dart';
import 'helper.dart';

Polynomial multPoly(Polynomial a, Polynomial b, int p) {
  int N = a.N;
  Polynomial c = Polynomial.fromDegree(N, d: N-1, coeff: 0);
  for(int k = 0; k < N; k++) {
    int ck1 = 0;
    for(int i = 0; i <= k; i++) {
      ck1 += a.coefficients[i] * b.coefficients[k-i];
    }
    int ck2 = 0;
    for (int i = k+1; i < N; i++) {
      ck2 += a.coefficients[i] * b.coefficients[k+N-i];
    }
    int ck = c.coefficients[k] + ck1 + ck2;
    c.coefficients[k] = ck % p;
  }
  return c;
}

void main() {
  int N = 347;
  Polynomial p1 = generateRandomPolynomial(N);
  Polynomial p2 = generateRandomPolynomial(N);

  var stopwatch = Stopwatch()..start();
  for (int i = 0; i < 5000; i++) {
    multPoly(p1, p2, 3);
  }
  print('New method ${stopwatch.elapsed}');
  stopwatch = Stopwatch()..start();
  for (int i = 0; i < 5000; i++) {
    (p1*p2).reduce(3);
  }
  print('Old method ${stopwatch.elapsed}');

  print(comparePoly(multPoly(p1, p2, 3), (p1*p2).reduce(3)));
}