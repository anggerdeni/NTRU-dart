import '../library/ntru_method_1.dart';
import '../library/ntru.dart'; // method 2
import '../library/ntru_method_3.dart';
import '../library/polynomial.dart';
import '../library/helper.dart';

String benchmark_ntru_1(int count) {
  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    new NTRUMethod1(397);
  }
  return 'NTRU Metode 1 key generation executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_2(int count) {
  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    new NTRU();
  }
  return 'NTRU Metode 2 key generation executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_3(int count) {
  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    new NTRUMethod3();
  }
  return 'NTRU Metode 3 key generation executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_1_encrypt(int count) {
  NTRUMethod1 ntru = new NTRUMethod1(397);
  int N = ntru.N;

  List<int> key = generateRandomInts(16);
  Polynomial msg = listOfIntToPolynomial(key, N);
  Polynomial r = generateRandomPolynomial(N);

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    ntru.encrypt(msg, r);
  }
  return 'NTRU Metode 1 encryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_1_decrypt(int count) {
  NTRUMethod1 ntru = new NTRUMethod1(397);
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
  return 'NTRU metode 1 decryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_2_encrypt(int count) {
  NTRU ntru = new NTRU();
  int N = ntru.N;

  List<int> key = generateRandomInts(16);
  Polynomial msg = listOfIntToPolynomial(key, N);
  Polynomial r = generateRandomPolynomial(N);

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    ntru.encrypt(msg, r);
  }
  return 'NTRU Metode 2 encryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_2_decrypt(int count) {
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
  return 'NTRU Metode 2 decryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_3_encrypt(int count) {
  NTRUMethod3 ntru = new NTRUMethod3();
  int N = ntru.N;

  List<int> key = generateRandomInts(16);
  Polynomial msg = listOfIntToPolynomial(key, N);
  Polynomial r = generateRandomPolynomial(N);

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    ntru.encrypt(msg, r);
  }
  return 'NTRU Metode 3 encryption executed in ${stopwatch.elapsed}';
}

String benchmark_ntru_3_decrypt(int count) {
  NTRUMethod3 ntru = new NTRUMethod3();
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
  return 'NTRU metode 3 decryption executed in ${stopwatch.elapsed}';
}

void main() {
  for (int i = 0; i < 10; i++) {
    print('#############################');
    print(benchmark_ntru_1(1000));
    print(benchmark_ntru_2(1000));
    print(benchmark_ntru_3(1000));
    print('----------------');
    print(benchmark_ntru_1_encrypt(10000));
    print(benchmark_ntru_2_encrypt(10000));
    print(benchmark_ntru_3_encrypt(10000));
    print('----------------');
    print(benchmark_ntru_1_decrypt(10000));
    print(benchmark_ntru_2_decrypt(10000));
    print(benchmark_ntru_3_decrypt(10000));
    print('----------------');
  }
}
