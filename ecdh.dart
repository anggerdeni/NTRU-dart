import 'package:cryptography/cryptography.dart';

void benchmark_key_exchange(int count, algorithm, aliceKeyPair, bobKeyPair, bobPublicKey) async {
  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    final sharedSecret = await algorithm.sharedSecretKey(
      keyPair: aliceKeyPair,
      remotePublicKey: bobPublicKey,
    );
  }
  print('ECDH key exchange executed in ${stopwatch.elapsed}');
}

void main() async {
  final algorithm = X25519();
  final aliceKeyPair = await algorithm.newKeyPair();
  final bobKeyPair = await algorithm.newKeyPair();
  final bobPublicKey = await bobKeyPair.extractPublicKey();
  benchmark_key_exchange(1000, algorithm, aliceKeyPair, bobKeyPair, bobPublicKey);
}