import 'helper.dart';
import 'polynomial.dart';

class NTRU {
  int _N;
  int _p;
  int _q;
  late Polynomial f;
  late Polynomial fp;
  late Polynomial g;
  late Polynomial h;

  NTRU(this._N, this._p, this._q) {
    Polynomial f = new Polynomial(1, [0]);
    Polynomial g = generateRandomPolynomial(_N);
    Polynomial fInvP = new Polynomial(1, [0]);
    Polynomial fInvQ = new Polynomial(1, [0]);
    Polynomial testP = new Polynomial(1, [0]);
    Polynomial testQ = new Polynomial(1, [0]);

    bool foundKeyPair = false;
    int regenerateKeyPairCount = 0;
    while(!foundKeyPair) {
      bool inverseFound = false;
      while(!inverseFound) {
        try {
          f = generateRandomPolynomial(_N);
          fInvP = inverse(f, _p);
          fInvQ = inverse(f, _q).reduce(_q);
          inverseFound = true;
        } catch(e) {
          print(e);
          continue;
        }
      }
      f = Polynomial(_N, f.coefficients.sublist(0,f.coefficients.length - 1));
      fInvP = Polynomial(_N, fInvP.coefficients.sublist(0,f.coefficients.length - 1)).reduce(_p);
      fInvQ = Polynomial(_N, fInvQ.coefficients.sublist(0,f.coefficients.length - 1)).reduce(_q);
      testP = (fInvP * f).reduce(_p);
      testQ = (fInvQ * f).reduce(_q);

      if(testP.isOne() && testQ.isOne()) {
        this.f = f;
        this.fp = fInvP;
        this.g = g;
        this.h = (fInvQ.multiplyInt(_p) * g).reduce(_q);
        foundKeyPair = true;
      }
      regenerateKeyPairCount++;
    }
    print('regenerate key attempt: $regenerateKeyPairCount');
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