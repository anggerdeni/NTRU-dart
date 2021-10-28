import 'helper.dart';
import 'polynomial.dart';

class NTRU {
  final int _N = 397;
  final int _p = 3;
  final int _q = 2048;
  late Polynomial f;
  late Polynomial fp;
  late Polynomial g;
  late Polynomial h;

  NTRU() {
    late Polynomial f;
    late Polynomial F;
    Polynomial g = generateRandomTrinaryPolynomialWithD(
        _N, (_N / 3).floor());
    late Polynomial fInvP;
    late Polynomial fInvQ;
    late Polynomial testP;
    late Polynomial testQ;

    bool foundKeyPair = false;
    while (!foundKeyPair) {
      bool inverseFound = false;
      while (!inverseFound) {
        try {
          F = generateRandomTrinaryPolynomialWithD(
              _N, (_N / 3).floor());
          f = F.multiplyInt(_p);
          f = f.addIntMod3(1);
          fInvP = Polynomial.fromDegree(_N, d: 1);
          fInvQ = inverseFq(f, this._q);
          inverseFound = true;
        } catch (e) {
          continue;
        }
      }
      testP = fInvP.multPolyMod3(f);
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

  NTRU.fromKeyPair(String strH, String strF, String strFp) {
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
