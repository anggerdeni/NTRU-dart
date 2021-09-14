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
          f = F.multiplyIntMod3(_p).addIntMod3(1);
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