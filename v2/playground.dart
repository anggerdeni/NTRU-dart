import 'library/ntru.dart';
import 'library/polynomial.dart';
import 'library/helper.dart';

void main() {
  NTRU ntruI = new NTRU();
  NTRU ntruJ = new NTRU();
  int N = ntruI.N;
  List<int> key = generateRandomInts(32);
  Polynomial msg = listOfIntToPolynomial(key, N);
}