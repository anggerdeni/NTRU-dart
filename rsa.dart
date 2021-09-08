import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:pointycastle/asymmetric/api.dart';

void benchmark_encrypt(int count, publicKey, privKey){
  final plainText = 'Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum';

  final stopwatchgeneration = Stopwatch()..start();
  final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
  // print('RSA generation executed in ${stopwatchgeneration.elapsed}');
  final stopwatch = Stopwatch()..start();

  for (int i = 0; i < count; i++) {
    encrypter.encrypt(plainText);
  }
  print('RSA Encryption executed in ${stopwatch.elapsed}');
}

void benchmark_decrypt(int count, publicKey, privKey) {
  
  final plainText = 'Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum';

  final stopwatchgeneration = Stopwatch()..start();
  final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
  // print('RSA generation executed in ${stopwatchgeneration.elapsed}');

  final encrypted = encrypter.encrypt(plainText);
  final stopwatch = Stopwatch()..start();

  for (int i = 0; i < count; i++) {
    encrypter.decrypt(encrypted);
  }
  print('RSA Decryption executed in ${stopwatch.elapsed}');
}

void main() async {
  final publicKey = await parseKeyFromFile<RSAPublicKey>('keypair/public.pem');
  final privKey = await parseKeyFromFile<RSAPrivateKey>('keypair/private.pem');
  benchmark_encrypt(1000, publicKey, privKey);
  benchmark_decrypt(1000, publicKey, privKey);
}