import 'helper.dart';
import 'polynomial.dart';

class NTRU {
  final int _N = 401;
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
          f = F.multiplyInt(_p).addInt(1).reduce(_p);
          fInvP = inverseF3(f);
          fInvQ = inverseFq(f, _q);
          inverseFound = true;
        } catch(e) {
          continue;
        }
      }
      testP = (fInvP * f).reduce(_p);
      testQ = (fInvQ * f).reduce(_q);

      if(testP.isOne() && testQ.isOne()) {
        this.f = f;
        this.fp = fInvP;
        this.g = g;
        this.h = (fInvQ.multiplyInt(_p) * g).reduce(_q);
        foundKeyPair = true;
      }
    }
  }

  Polynomial get publicKey {
    return this.h;
  }

  List<Polynomial> get privateKey {
    return [this.f, this.fp];
  }

  Polynomial encrypt(Polynomial message) {
    if(message.N != _N) throw new Exception('Message should have same N');
    Polynomial r = generateRandomPolynomial(_N);
    return (r*h + message).reduce(_q);
  }

  Polynomial decrypt(Polynomial cipher) {
    Polynomial a = (this.f * cipher).reduceCenterLift(this._q);
    a = a.reduceCenterLift(this._p);
    return (this.fp * a).reduceCenterLift(this._p);
  }
}