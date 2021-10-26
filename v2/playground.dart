import 'library/NTRULLL.dart';
import 'library/ntru.dart';
import 'library/helper.dart';
import 'library/polynomial.dart';

void main() {
  // for (int N = 7; N < 50; N++) {
  //   NTRULLL ntru = new NTRULLL(N);
  //   print("-----------");
  //   print(N);
  //   print(ntru.f.coefficients);
  //   print(ntru.h.coefficients);
  // }

  NTRU ntruI = new NTRU();
  NTRU ntruJ = new NTRU();

  int N = ntruI.N;

  List<int> key = generateRandomInts(16);
  Polynomial msg = listOfIntToPolynomial(key, N);
  Polynomial r = generateRandomPolynomial(N);
  Polynomial e = ntruI.encrypt(msg, r);

  Polynomial d = ntruI.decrypt(e);
  if (!comparePoly(d, msg))
    throw new Exception('decryption failed');

  print(comparePoly(ntruJ.decrypt(e), msg));
}
