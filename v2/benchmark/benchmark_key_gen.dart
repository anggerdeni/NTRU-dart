import '../library/ntru.dart';
import '../library/ntru_method_2.dart';
import '../library/polynomial.dart';
import '../library/helper.dart';

String benchmark_ntru_1(int count) {
  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    new NTRU();
  }
  return 'NTRU encryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_2(int count) {
  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    new NTRUMethod2();
  }
  return 'NTRUMethod2 encryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_1_encrypt(int count) {
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

String benchmark_ntru_1_decrypt(int count) {
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

String benchmark_ntru_2_encrypt(int count) {
  NTRUMethod2 ntru = new NTRUMethod2();
  int N = ntru.N;
  
  List<int> key = generateRandomInts(16);
  Polynomial msg = listOfIntToPolynomial(key, N);
  Polynomial r = generateRandomPolynomial(N);

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    ntru.encrypt(msg, r);
  }
  return 'NTRUMethod2 encryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_2_decrypt(int count) {
  NTRUMethod2 ntru = new NTRUMethod2();
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
  return 'NTRUMethod2 decryption executed in ${stopwatch.elapsed}';
}

void main() {
  // for(int i = 0; i < 10; i++) {
  //   print('--------------------------------------------------------');
  //   print(benchmark_ntru_1(10000));
  //   print(benchmark_ntru_2(10000));
  // }

  // for(int i = 0; i < 10; i++) {
  //   print('--------------------------------------------------------');
  //   print(benchmark_ntru_1_encrypt(100000));
  //   print(benchmark_ntru_2_encrypt(100000));
  // }

  for(int i = 0; i < 10; i++) {
    print('--------------------------------------------------------');
    print(benchmark_ntru_1_decrypt(100000));
    print(benchmark_ntru_2_decrypt(100000));
  }
}