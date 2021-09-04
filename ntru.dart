import 'polynomial.dart';

class NTRU {
  int _N;
  int _p;
  int _q;

  // todo:
  // kunci publik, privat

  NTRU(int this._N, int this._p, int this._q);

  int get N {
    return this._N;
  }

  int get p {
    return this._p;
  }

  int get q {
    return this._q;
  }

  set N(int N) {
    this._N = N;
  }

  set p(int p) {
    this._p = p;
  }

  set q(int q) {
    this._q = q;
  }
}