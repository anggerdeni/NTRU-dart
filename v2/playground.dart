import 'library/NTRULLL.dart';
import 'library/ntru.dart';
import 'library/helper.dart';
import 'library/polynomial.dart';

void main() {
  for (int N = 40; N < 42; N++) {
    NTRULLL ntru = new NTRULLL(N);
    print("# -----------");
    print("f_s.append(${ntru.f.coefficients})");
    print("h_s.append(${ntru.h.coefficients})");
  }
}
