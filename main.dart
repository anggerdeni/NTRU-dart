import 'ntru.dart';
import 'polynomial.dart';
import 'helper.dart';

void benchmark_encrypt(int count) {
  int N = 401;

  final stopwatchgeneration = Stopwatch()..start();
  NTRU ntru = new NTRU();
  // print('NTRU generation executed in ${stopwatchgeneration.elapsed}');
  
  Polynomial msg = generateRandomPolynomial(N);

  final stopwatch = Stopwatch()..start();

  for (int i = 0; i < count; i++) {
    ntru.encrypt(msg);
  }
  print('NTRU Encryption executed in ${stopwatch.elapsed}');
}

void benchmark_decrypt(int count) {
  int N = 401;

  final stopwatchgeneration = Stopwatch()..start();
  NTRU ntru = new NTRU();
  // print('NTRU generation executed in ${stopwatchgeneration.elapsed}');

  Polynomial msg = generateRandomPolynomial(N);
  Polynomial e = ntru.encrypt(msg);

  Polynomial d = ntru.decrypt(e);
  if(!comparePoly(d, msg)) throw new Exception('decryption failed');

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    ntru.decrypt(e);
  }
  print('NTRU Decryption executed in ${stopwatch.elapsed}');
  
}

void main() {
  benchmark_encrypt(100);
  benchmark_decrypt(100);
}