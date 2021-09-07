import 'ntru.dart';
import 'polynomial.dart';
import 'helper.dart';

void main() {
  int p = 3;
  int q = 256;
  int N = 10;
  // N = 503;

  NTRU ntru = new NTRU(N, p, q);
  // print(ntru.publicKey.coefficients);

  Polynomial msg = generateRandomPolynomial(N);
  Polynomial e = ntru.encrypt(msg);
  Polynomial d = ntru.decrypt(e);
  print('msg ${msg.coefficients}');
  print('e ${e.coefficients}');
  print('d ${d.coefficients}');
  for( int i = 0; i < d.coefficients.length; i++) {
    d.coefficients[i] = d.coefficients[i] - msg.coefficients[i];
  }
  print('d ${d.coefficients}');
  print('decryption ${d.isZero() ? "success" : "failed"}');


  // Polynomial polynom1 = generateRandomPolynomial(N).reduce(p);

  // Polynomial invP = inverse(polynom1, p);
  // Polynomial invQ = inverse(polynom1, q).reduce(q);
  // invP = Polynomial(N, invP.coefficients).reduce(p);
  // invQ = Polynomial(N, invQ.coefficients).reduce(q);
  // Polynomial testP = (invP * polynom1).reduce(p);
  // Polynomial testQ = (invQ * polynom1).reduce(q);
  // print(testP.coefficients);
  // print(testQ.coefficients);
}