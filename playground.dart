import 'helper.dart';
import 'dart:convert';
import 'polynomial.dart';
void main() {
  List<int> key = generateRandomInts(16);
  Polynomial msg = listOfIntToPolynomial(key, 347);
  int numChunks = 16;

  List<int> bytes = [];
  String str = msg.coefficients.join();
  for(int i = 0, o = 0; i < numChunks; i++, o+=8) {
    bytes.add(int.parse(str.substring(o, o+8), radix: 2));
  }
  print(base64.encode(bytes));
  print(base64.encode(key));
}