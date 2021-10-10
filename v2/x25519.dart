import 'package:cryptography/cryptography.dart';

Future<String> benchmark_x25519_key_exchange(int count) async {
  final algorithm = X25519();
  final aliceKeyPair = await algorithm.newKeyPair();
  final bobKeyPair = await algorithm.newKeyPair();
  final bobPublicKey = await bobKeyPair.extractPublicKey();

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    final sharedSecret = await algorithm.sharedSecretKey(
      keyPair: aliceKeyPair,
      remotePublicKey: bobPublicKey,
    );
    await sharedSecret.extractBytes();
  }
  return 'X25519 key exchange executed in ${stopwatch.elapsed}';
}

void main() {
  print(benchmark_x25519_key_exchange(1000));
}