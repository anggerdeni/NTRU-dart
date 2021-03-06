import 'helper.dart';
import 'polynomial.dart';

class NTRUMethod1 {
  late int _N;
  final int _p = 3;
  final int _q = 2048;
  late Polynomial f;
  late Polynomial fp;
  late Polynomial g;
  late Polynomial h;

  NTRUMethod1(this._N) {
    Polynomial f = generateRandomPolynomial(_N);
    Polynomial g = generateRandomPolynomial(_N);
    Polynomial fInvP = new Polynomial(1, [0]);
    Polynomial fInvQ = new Polynomial(1, [0]);
    Polynomial testP = new Polynomial(1, [0]);
    Polynomial testQ = new Polynomial(1, [0]);

    bool foundKeyPair = false;
    while (!foundKeyPair) {
      bool inverseFound = false;
      while (!inverseFound) {
        try {
          f = generateRandomPolynomial(_N);
          fInvP = inverseF3(f);
          fInvQ = inverseFq(f, this._q);
          inverseFound = true;
        } catch (e) {
          continue;
        }
      }
      testP = fInvP.multPolyModInt(f, 3);
      testQ = fInvQ.multPoly(f, _q);

      if (testP.isOne() && testQ.isOne()) {
        this.f = f;
        this.fp = fInvP;
        this.g = g;
        this.h = fInvQ.multiplyInt(_p).multPoly(g, _q);
        foundKeyPair = true;
      }
    }
  }

  NTRUMethod1.fromKeyPair(
      String strH, String strF, String strFp) {
    this.h = Polynomial.fromCommaSeparatedCoefficients(
        this._N, strH);
    this.f = Polynomial.fromCommaSeparatedCoefficients(
        this._N, strF);
    this.fp = Polynomial.fromCommaSeparatedCoefficients(
        this._N, strFp);
  }

  int get N {
    return this._N;
  }

  Polynomial get publicKey {
    return this.h;
  }

  List<Polynomial> get privateKey {
    return [this.f, this.fp];
  }

  Polynomial encrypt(Polynomial message, Polynomial r) {
    if (message.N != _N)
      throw new Exception('Message should have same N');
    return r
        .multiplyIntMod2048(_p)
        .multPolyMod2048(this.h)
        .addPolyMod2048(message);
  }

  Polynomial decrypt(Polynomial cipher) {
    Polynomial a = this.f.multPolyModCenterLift2048(cipher);
    return this.fp.multPolyModCenterLift3(a);
  }
}
