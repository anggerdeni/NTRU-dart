import 'dart:math';
import 'polynomial.dart';
import 'dart:typed_data';

double log2(int x) {
  return log(x) / log(2);
}

String I2BSP (int x, int bLen) {
  if (x >= pow(2, bLen)) throw new Exception('Number too large');
  return x.toRadixString(2).padLeft(bLen, '0');
}

int BS2IP (String x) {
  return int.parse(x, radix: 2);
}

List<int> I2OSP (int x, int oLen) {
  // little endian, reverse after finish
  List<int> result = Uint8List(oLen)..buffer.asByteData().setInt16(0, x, Endian.little);
  return result;
}

int OS2IP(List<int> x) {
  int result = 0;
  for (int i = 0; i<x.length; i++) {
    result += x[i] * pow(256, i).floor();
  }
  return result;
}

List<String> RE2BSP(List<int> x, int q) {
  List<String> result = List.filled(x.length, '');
  for (int j = 0; j < x.length; j++) {
    result[j] += I2BSP(x[j] % q, log2(q).ceil());
  }
  return result;
}

List<int> BS2REP(List<String> B, int N, int q) {
  if (B.length != N *log2(q).ceil()) throw 'bit string incorrect length';
  List<int> a = List.filled(B.length, 0);
  for (int j = 0; j < N; j++) {
    a[j] += BS2IP(B[j]);
  }
  return a;
}

int IGFRBG(int N, int c) {
  int result = 0;
  bool success = false;
  int cLen = (c/8).ceil();
  Random rand = Random.secure();
  while (!success) {
    String b = '';
    for(int i = 0; i < cLen; i++) {
      b += I2BSP(rand.nextInt(256), 8);
    }
    b = '0'*(c) + b.substring(c);
    print(b);
    result = BS2IP(b);
    if(result < pow(2, c) - (pow(2, c) % N)) success = true;
  }
  return result % N;
}

List<Polynomial> egcd(Polynomial a, Polynomial b, int p) {
  Polynomial d = a.clone();
  Polynomial v1 = Polynomial.fromDegree(a.N, d: 0, coeff: 0);
  Polynomial v3 = b.clone();
  Polynomial u = Polynomial.fromDegree(a.N, d: 0, coeff: 1);
  if(b.isZero()) {
    return [u, v1, d];
  }

  while(!v3.isZero()) {
    List<Polynomial> tmp = d.div(v3, p);
    Polynomial q = tmp[0];
    Polynomial t3 = tmp[1];
    if(t3.getDegree() > v3.getDegree()) throw new Exception('Something wrong');

    Polynomial t1 = (u - q * v1).reduce(p);
    u.coefficients = List.from(v1.coefficients);
    d.coefficients = List.from(v3.coefficients);
    v1.coefficients = List.from(t1.coefficients);
    v3.coefficients = List.from(t3.coefficients);
  }

  List<Polynomial> tmp = ((d - a * u).reduce(p).div(b, p));
  Polynomial v = tmp[0];
  Polynomial r = tmp[1];
  if(!r.isZero()) {
    throw new Exception('Division not resulting in 0 ${r.coefficients}');
  };

  return [u, v, d];
}

Polynomial inverse(Polynomial a, int p) {
  List<int> coeffA = List.from(a.coefficients);
  coeffA.add(0); // padding
  a = new Polynomial(a.N+1, coeffA);
  Polynomial XN_1 = new Polynomial.fromDegree(a.N, d: a.N-1);
  XN_1.coefficients[0] = -1; // x^N - 1

  List<Polynomial>tmp = egcd(a, XN_1, p);
  Polynomial u = tmp[0];
  Polynomial d = tmp[2];
  if(d.getDegree() == 0) {
    int dInv = d.coefficients[0].modInverse(p);
    return u.multiplyInt(dInv);
  }
  throw new Exception('No inverse found');
}

List<int> randomCoefficients(int length, int d, int neg_ones_diff) {
  List<int> zeros = List.filled(length - 2*d - neg_ones_diff, 0);
  List<int> ones = List.filled(d, 1);
  List<int> neg_ones = List.filled(d + neg_ones_diff, -1);
  List<int> result = List.from(zeros)..addAll(ones)..addAll(neg_ones);
  result.shuffle();
  return result;
}

Polynomial generateRandomPolynomial(int N, { List<int>? options }) {
  List<int> coeff = List.filled(N, 0);
  if(options == null) {
    options = [-1,0,1];
  }
  Random rand = new Random();
  for (int i = 0; i < N; i++) {
    // randomize -1,0,1
    coeff[i] = options[rand.nextInt(options.length)];
  }

  return new Polynomial(N, coeff);
}

Polynomial generateRandomPolynomial2(int N) {
  List<int> coeff = randomCoefficients(N, (N/3).floor(), -1);
  return new Polynomial(N, coeff);
}