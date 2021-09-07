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
    Polynomial g = generateRandomPolynomial(_N).reduce(_p);
    Polynomial fInvP = new Polynomial(1, [0]);
    Polynomial fInvQ = new Polynomial(1, [0]);
    Polynomial testP = new Polynomial(1, [0]);
    Polynomial testQ = new Polynomial(1, [0]);

    bool foundKeyPair = false;
    int i = 0;
    while(!foundKeyPair) {
      i++;
      // print(i);
      bool inverseFound = false;
      int j = 0;
      while(!inverseFound) {
        j++;
        // print('inv-$j');
        try {
          f = generateRandomPolynomial(_N).reduce(_p);
          fInvP = inverse(f, _p);
          fInvQ = inverse(f, _q).reduce(_q);
          inverseFound = true;
        } catch(e) {
          continue;
        }
      }
      f = Polynomial(_N, f.coefficients.sublist(0,f.coefficients.length - 1)).reduce(_p);
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