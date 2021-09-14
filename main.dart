import 'ntru.dart';
import 'polynomial.dart';
import 'helper.dart';

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
  if(!comparePoly(d, msg)) throw new Exception('decryption failed');

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    ntru.decrypt(e);
  }
  return 'NTRU decryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_key_exchange(int count) {
  NTRU ntru = new NTRU();
  int N = ntru.N;

  List<int> key1 = generateRandomInts(16);
  List<int> key2 = generateRandomInts(16);
  Polynomial msg1 = listOfIntToPolynomial(key1, N);
  Polynomial msg2 = listOfIntToPolynomial(key2, N);
  Polynomial r = generateRandomPolynomial(N);
  Polynomial e1 = ntru.encrypt(msg1, r);
  Polynomial e2 = ntru.encrypt(msg2, r);
  List<int> final_key = [];

  Polynomial d = ntru.decrypt(e1);
  if(!comparePoly(d, msg1)) throw new Exception('decryption failed');
  d = ntru.decrypt(e2);
  if(!comparePoly(d, msg2)) throw new Exception('decryption failed');

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    e1 = ntru.encrypt(msg1, r);
    final_key..addAll(key1)..addAll(polynomialToListOfInt(ntru.decrypt(e2)));
  }
  return 'NTRU key exchange executed in ${stopwatch.elapsed}';
}


void main() {
  // print(benchmark_ntru_encrypt(1000));
  // print(benchmark_ntru_decrypt(1000));
  print(benchmark_ntru_key_exchange(1000));
}