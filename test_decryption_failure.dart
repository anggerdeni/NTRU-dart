import 'ntru_might_fail.dart';
import 'ntru.dart';
import 'polynomial.dart';
import 'helper.dart';

void ntru_full_operation(int count) {
  for (int i = 0; i < count; i++) {
    NTRU ntru = new NTRU();
    int N = ntru.N;
    List<int> key1 = generateRandomInts(16);
    Polynomial msg1 = listOfIntToPolynomial(key1, N);
    Polynomial r = generateRandomPolynomial(N);
    Polynomial d = ntru.decrypt(ntru.encrypt(msg1, r));
    if(!comparePoly(d, msg1)) {
      print('decryption failure');
    }
  }
}

int ntru_full_operation_2(int count) {
  int result = 0;
  for (int i = 0; i < count; i++) {
    NTRUMightFail ntru = new NTRUMightFail();
    int N = ntru.N;
    List<int> key1 = generateRandomInts(16);
    Polynomial msg1 = listOfIntToPolynomial(key1, N);
    Polynomial r = generateRandomPolynomial(N);
    Polynomial d = ntru.decrypt(ntru.encrypt(msg1, r));
    if(!comparePoly(d, msg1)) {
      result++;
    }
  }
  return result;
}


void main() {
  for(int i = 0; i < 1000; i++) {
    int x = ntru_full_operation_2(10000);
    if(x > 0) {
      print("Decryption failure: ${x}/10000");
    }
  }
}