import 'polynomial.dart';
import 'helper.dart';

Polynomial multPoly(Polynomial a, Polynomial b, int p) {
  int N = a.N;
  Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
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
int mod3(int x) {
  // https://compilers.iecc.com/comparch/article/99-10-056
  int a = x & 0x33333333; /* even two-bit groups */
  int b = x & 0xcccccccc; /* odd two-bit groups */
  int sum = a + (b >> 2); /* sum 0-6 in 8 groups */
  sum = sum + (sum >> 2); /* sum 0-3 in 8 groups */
  sum = sum & 0x33333333; /* clear garbage bits */
  sum = sum + (sum >> 4); /* sum 0-6 in 4 groups */
  sum = sum + (sum >> 2); /* sum 0-3 in 4 groups */
  sum = sum & 0x33333333; /* clear garbage bits */
  sum = sum + (sum >> 8); /* sum 0-6 in 2 groups */
  sum = sum + (sum >> 2); /* sum 0-3 in 2 groups */
  sum = sum & 0x33333333; /* clear garbage bits */
  sum = sum + (sum >> 16); /* sum 0-6 in 1 group */
  sum = sum + (sum >> 2); /* sum 0-3 in 1 group */
  sum = sum & 0x3; /* clear garbage bits */
  return sum;
}
void main() {
  int x = 0;
  var stopwatch = Stopwatch()..start();
  for (int i = 0; i < 50000; i++) {
    x = 4023 & 2047;
  }
  print('New method ${stopwatch.elapsed}');
  stopwatch = Stopwatch()..start();
  for (int i = 0; i < 50000; i++) {
    x = 4023 % 2048;
  }
  print('Old method ${stopwatch.elapsed}');
}