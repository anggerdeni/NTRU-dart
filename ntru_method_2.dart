import 'helper.dart';
import 'polynomial.dart';

class NTRUMethod2 {
  final int _N = 397;
  final int _p = 3;
  final int _q = 2048;
  late Polynomial f;
  late Polynomial fp;
  late Polynomial g;
  late Polynomial h;

  NTRUMethod2() {
    Polynomial f = new Polynomial(1, [0]);
    Polynomial f1 = new Polynomial(1, [0]);
    Polynomial f2 = new Polynomial(1, [0]);
    Polynomial f3 = new Polynomial(1, [0]);
    Polynomial g = generateRandomPolynomial(_N);
    Polynomial fInvP = new Polynomial(1, [0]);
    Polynomial fInvQ = new Polynomial(1, [0]);
    Polynomial testP = new Polynomial(1, [0]);
    Polynomial testQ = new Polynomial(1, [0]);

    bool foundKeyPair = false;
    while(!foundKeyPair) {
      bool inverseFound = false;
      while(!inverseFound) {
        try {
          f1 = generateRandomPolynomialMethod2(_N);
          f2 = generateRandomPolynomialMethod2(_N);
          f3 = generateRandomPolynomialMethod2(_N);
          f = f1.multPoly(f2, 3).addPolyMod3(f3).multiplyIntMod3(_p).addIntMod3(1);
          fInvP = inverseF3(f);
          fInvQ = inverseFq(f);
          inverseFound = true;
        } catch(e) {
          continue;
        }
      }
      testP = fInvP.multPolyMod3(f);
      testQ = fInvQ.multPoly(f,_q);

      if(testP.isOne() && testQ.isOne()) {
        this.f = f;
        this.fp = fInvP;
        this.g = g;
        this.h = fInvQ.multiplyInt(_p).multPoly(g, _q);
        foundKeyPair = true;
      }
    }
  }

  NTRUMethod2.fromKeyPair(String strH, String strF, String strFp) {
    this.h = Polynomial.fromCommaSeparatedCoefficients(this._N, strH);
    this.f = Polynomial.fromCommaSeparatedCoefficients(this._N, strF);
    this.fp = Polynomial.fromCommaSeparatedCoefficients(this._N, strFp);
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
    if(message.N != _N) throw new Exception('Message should have same N');
    return r.multPolyMod2048(this.h).addPolyMod2048(message);
  }

  Polynomial decrypt(Polynomial cipher) {
    Polynomial a = this.f.multPolyModCenterLift2048(cipher);
    return this.fp.multPolyModCenterLift3(a);
  }
}