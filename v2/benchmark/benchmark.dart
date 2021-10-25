import '../main.dart';
import '../rsa.dart';
import '../x25519.dart';

void main(List<String> args) async {
  if (args.length < 3) {
    print(
        '[+] Usage: dart <path_to_file> COMMAND COUNT [...algs]');
    print('[>] List of commands:');
    print('[-]    - kem');
    print('[-]    - encryption');
    print('[-]    - decryption');
    print('[>] List of algs:');
    print('[-]    - NTRU');
    print('[-]    - RSA');
    print('[-]    - ECC');
    return;
  }
  try {
    var x25519, ntru, rsa;
    var ntru_e, rsa_e;
    var ntru_d, rsa_d;
    int count = int.parse(args[1]);
    switch (args[0]) {
      case 'kem':
        if (args.contains('NTRU')) {
          ntru = await benchmark_ntru_key_exchange(count);
          print(ntru);
        }
        if (args.contains('RSA')) {
          rsa = await benchmark_rsa_key_exchange(count);
          print(rsa);
        }
        if (args.contains('ECC')) {
          x25519 =
              await benchmark_x25519_key_exchange(count);
          print(x25519);
        }
        print(
            '--------------------------------------------------------');
        break;
      case 'encryption':
        if (args.contains('NTRU')) {
          ntru_e = await benchmark_ntru_encrypt(count);
          print(ntru_e);
        }
        if (args.contains('RSA')) {
          rsa_e = await benchmark_rsa_encrypt(count);
          print(rsa_e);
        }
        if (args.contains('ECC')) {
          print('X25519 cannot execute direct encryption');
        }
        print(
            '--------------------------------------------------------');
        break;
      case 'decryption':
        if (args.contains('NTRU')) {
          ntru_d = await benchmark_ntru_decrypt(count);
          print(ntru_d);
        }
        if (args.contains('RSA')) {
          rsa_d = await benchmark_rsa_decrypt(count);
          print(rsa_d);
        }
        if (args.contains('ECC')) {
          print('X25519 cannot execute direct decryption');
        }
        print(
            '--------------------------------------------------------');
        break;
      default:
        print('command not found');
        break;
    }
  } catch (e) {
    print(e);
  }
}
