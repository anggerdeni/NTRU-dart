import 'ntru.dart';
import 'polynomial.dart';
import 'helper.dart';

void benchmark_encrypt(int count) {
  final stopwatchgeneration = Stopwatch()..start();
  NTRU ntru = new NTRU();
  int N = ntru.N;
  // print('NTRU generation executed in ${stopwatchgeneration.elapsed}');
  
  Polynomial msg = generateRandomPolynomial(N);

  final stopwatch = Stopwatch()..start();

  Polynomial r = generateRandomPolynomial(N);
  for (int i = 0; i < count; i++) {
    ntru.encrypt(msg, r);
  }
  print('NTRU Encryption executed in ${stopwatch.elapsed}');
}

void benchmark_decrypt(int count) {
  final stopwatchgeneration = Stopwatch()..start();
  NTRU ntru = new NTRU();
  int N = ntru.N;
  // print('NTRU generation executed in ${stopwatchgeneration.elapsed}');

  Polynomial msg = generateRandomPolynomial(N);
  Polynomial r = generateRandomPolynomial(N);
  Polynomial e = ntru.encrypt(msg, r);

  Polynomial d = ntru.decrypt(e);
  if(!comparePoly(d, msg)) throw new Exception('decryption failed');

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    ntru.decrypt(e);
  }
  print('NTRU Decryption executed in ${stopwatch.elapsed}');
}

void main() {
  benchmark_encrypt(1000);
  benchmark_decrypt(1000);
}