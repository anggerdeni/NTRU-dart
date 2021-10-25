import 'library/ntru.dart';
import 'library/polynomial.dart';
import 'library/helper.dart';

String benchmark_ntru_encrypt(int count) {
  NTRU ntru = new NTRU();
  int N = ntru.N;

  List<int> key = generateRandomInts(16);
  Polynomial msg = listOfIntToPolynomial(key, N);
  Polynomial r = generateRandomPolynomial(N);

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    ntru.encrypt(msg, r);
  }
  return 'NTRU encryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_decrypt(int count) {
  NTRU ntru = new NTRU();
  int N = ntru.N;

  List<int> key = generateRandomInts(16);
  Polynomial msg = listOfIntToPolynomial(key, N);
  Polynomial r = generateRandomPolynomial(N);
  Polynomial e = ntru.encrypt(msg, r);

  Polynomial d = ntru.decrypt(e);
  if (!comparePoly(d, msg))
    throw new Exception('decryption failed');

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    ntru.decrypt(e);
  }
  return 'NTRU decryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_key_exchange(int count) {
  NTRU ntruI = new NTRU();
  int N = ntruI.N;
  Polynomial rJ = generateRandomPolynomial(N);
  Polynomial eJ = generateRandomPolynomial(N);
  Polynomial kemI = generateRandomPolynomial(N);
  List<int> key = generateRandomInts(32);
  Polynomial msgJ = listOfIntToPolynomial(key, N);

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    eJ = rJ.multPolyMod2048(ntruI.h).addPolyMod2048(msgJ);
    kemI = ntruI.decrypt(eJ);
    List<int> aesKey = [];
    aesKey
        .addAll(polynomialToListOfInt(kemI, numChunks: 32));
  }
  return 'NTRU key exchange executed in ${stopwatch.elapsed}';
}

void main() {
  // print(benchmark_ntru_encrypt(1000));
  // print(benchmark_ntru_decrypt(1000));
  print(benchmark_ntru_key_exchange(1000));
}
