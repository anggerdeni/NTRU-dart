import 'library/NTRULLL.dart';
import 'library/ntru.dart';
import 'library/ntru_method_3.dart';
import 'library/helper.dart';
import 'library/polynomial.dart';

void main() {
  // for (int N = 40; N < 42; N++) {
  //   NTRULLL ntru = new NTRULLL(N);
  //   print("# -----------");
  //   print("f_s.append(${ntru.f.coefficients})");
  //   print("h_s.append(${ntru.h.coefficients})");
  // }
  NTRU ntru1 = new NTRU();
  NTRU ntru2 = new NTRU();
  int N = ntru1.N;
  Polynomial r = generateRandomPolynomial(N);
  List<int> key = generateRandomInts(16);
  Polynomial msg = listOfIntToPolynomial(key, N);

  Polynomial e = ntru1.encrypt(msg, r);
  Polynomial d = ntru2.decrypt(e);
  Polynomial dd = ntru1.decrypt(e);

  print(comparePoly(msg, d));
  print(comparePoly(msg, dd));

  NTRUMethod3 ntru3 = new NTRUMethod3();
  NTRUMethod3 ntru4 = new NTRUMethod3();
  e = ntru3.encrypt(msg, r);
  d = ntru4.decrypt(e);
  dd = ntru3.decrypt(e);
  print(comparePoly(msg, d));
  print(comparePoly(msg, dd));

  print(ntru1.f.coefficients);
  print(ntru2.f.coefficients);
  print(ntru3.fp.coefficients);
  print(ntru4.fp.coefficients);
}
