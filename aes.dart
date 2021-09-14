import 'package:encrypt/encrypt.dart';
import 'helper.dart';

void main() {
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = Key.fromBase64(generateRandomBytes(32));
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(decrypted);
  print(encrypted.base64);
}