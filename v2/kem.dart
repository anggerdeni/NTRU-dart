import 'library/ntru.dart';
import 'library/polynomial.dart';
import 'library/helper.dart';


List<int> main() {
  NTRU ntruI = new NTRU();
  NTRU ntruJ = new NTRU();
  int N = ntruI.N;
  Polynomial rI = generateRandomPolynomial(N);
  Polynomial rJ = generateRandomPolynomial(N);

  List<int> key = generateRandomInts(32);
  Polynomial msgI = listOfIntToPolynomial(key, N);
  Polynomial msgJ = listOfIntToPolynomial(key, N);

  Polynomial eI = rI
      .multPolyMod2048(ntruJ.h)
      .addPolyMod2048(msgI);
  Polynomial eJ = rJ
      .multPolyMod2048(ntruI.h)
      .addPolyMod2048(msgJ);

  Polynomial kemI = ntruI.decrypt(eJ);
  Polynomial kemJ = ntruJ.decrypt(eI);

  if(comparePoly(kemI, msgJ)) print("kemI == msgJ");
  if(comparePoly(kemJ, msgI)) print("kemJ == msgI");

  List<int> aesKey = [];
  aesKey.addAll(polynomialToListOfInt(kemI, numChunks: 32));
  print(aesKey.length);
  return aesKey;
}