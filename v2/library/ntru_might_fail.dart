import 'helper.dart';
import 'polynomial.dart';

class NTRUMightFail {
  final int _N = 397;
  final int _p = 3;
  final int _q = 512;
  late Polynomial f;
  late Polynomial fp;
  late Polynomial g;
  late Polynomial h;

  NTRUMightFail() {
    Polynomial f = new Polynomial(1, [0]);
    Polynomial F = new Polynomial(1, [0]);
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
          F = generateRandomPolynomial(_N);
          f = F.multiplyIntModInt(_p, 3).addIntModInt(1, 3);
          fInvP = inverseF3(f);
          fInvQ = inverseFq(f, this._q);
          inverseFound = true;
        } catch(e) {
          continue;
        }
      }
      testP = fInvP.multPolyModInt(f, 3);
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

  NTRUMightFail.fromKeyPair(String strH, String strF, String strFp) {
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
    return r.multPolyModPowerOfTwo(this.h, this._q).addPolyModPowerOfTwo(message, this._q);
  }

  Polynomial decrypt(Polynomial cipher) {
    Polynomial a = this.f.multPolyModCenterLiftPowerOfTwo(cipher, this._q);
    return this.fp.multPolyModInt(a, 3);
  }
}