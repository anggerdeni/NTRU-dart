import 'main.dart';
import 'rsa.dart';
import 'x25519.dart';

void main() async {
  int count = 1000;
  var x25519, ntru, rsa;
  var x25519_e, ntru_e, rsa_e;
  var x25519_d, ntru_d, rsa_d;
  /**
   * 
    benchmark_rsa_encrypt
    benchmark_rsa_decrypt
    benchmark_ntru_encrypt
    benchmark_ntru_decrypt
   */
  for(int i = 0; i < 10; i++) {
    /** benchmark key exchange */
    // x25519 = await benchmark_x25519_key_exchange(count);
    // rsa = benchmark_rsa_key_exchange(count);
    // ntru = benchmark_ntru_key_exchange(count);
    // print(ntru);
    // print(x25519);
    // print(rsa);
    // print('--------------------------------------------------------');

    /** benchmark encryption */
    // ntru_e = benchmark_ntru_encrypt(count);
    // rsa_e = benchmark_rsa_encrypt(count);
    // print(ntru_e);
    // print(rsa_e);
    // print('--------------------------------------------------------');

    /** benchmark decryption */
    // ntru_d = benchmark_ntru_decrypt(count);
    // rsa_d = benchmark_rsa_decrypt(count);
    // print(ntru_d);
    // print(rsa_d);
    // print('--------------------------------------------------------');
  }
}