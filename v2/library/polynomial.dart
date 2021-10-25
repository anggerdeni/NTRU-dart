class Polynomial {
  int _N;
  List<int> _coefficients = [];

  Polynomial(this._N, this._coefficients);

  Polynomial.fromDegree(this._N, {required d, coeff}) {
    if (d >= this._N)
      throw Exception('Data length should be less than or equal to N');
    this._coefficients = new List.filled(this._N, 0);
    if (coeff != null)
      this._coefficients[d] = coeff;
    else
      this._coefficients[d] = 1;
  }

  Polynomial.fromCommaSeparatedCoefficients(
      this._N, String commaSeparatedValues) {
    this._coefficients =
        commaSeparatedValues.split(',').map((i) => int.parse(i)).toList();
  }

  List<int> get coefficients {
    return this._coefficients;
  }

  int get N {
    return this._N;
  }

  set coefficients(List<int> coefficients) {
    this._coefficients = coefficients;
  }

  set N(int N) {
    this._N = N;
  }

  Polynomial multiplyInt(int b) {
    List<int> result = [];

    for (int i = 0; i < this._coefficients.length; i += 1) {
      result.add(this._coefficients[i] * b);
    }

    return Polynomial(this._N, result);
  }

  Polynomial modInt(int mod) {
    List<int> result = [];

    for (int i = 0; i < this._coefficients.length; i += 1) {
      result.add(this._coefficients[i] % mod);
    }

    return Polynomial(this._N, result);
  }

  Polynomial multiplyIntModInt(int b, int mod) {
    List<int> result = [];

    for (int i = 0; i < this._coefficients.length; i += 1) {
      result.add((this._coefficients[i] * b) % mod);
    }

    return Polynomial(this._N, result);
  }
  
  Polynomial multiplyIntMod3(int b) {
    List<int> result = [];

    for (int i = 0; i < this._coefficients.length; i += 1) {
      result.add((this._coefficients[i] * b) % 3);
    }

    return Polynomial(this._N, result);
  }

  Polynomial multiplyIntMod2048(int b) {
    List<int> result = [];

    for (int i = 0; i < this._coefficients.length; i += 1) {
      result.add((this._coefficients[i] * b) % 2048);
    }

    return Polynomial(this._N, result);
  }
  
  Polynomial multPoly(Polynomial b, int modulo) {
    int N = this.N;
    Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
    for (int k = 0; k < N; k++) {
      int ck1 = 0;
      for (int i = 0; i <= k; i++) {
        ck1 += this.coefficients[i] * b.coefficients[k - i];
      }
      int ck2 = 0;
      for (int i = k + 1; i < N; i++) {
        ck2 += this.coefficients[i] * b.coefficients[k + N - i];
      }
      int ck = c.coefficients[k] + ck1 + ck2;
      c.coefficients[k] = ck % modulo;
    }
    return c;
  }

  Polynomial multPolyModPowerOfTwo(Polynomial b, int mod) {
    int N = this.N;
    Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
    for (int k = 0; k < N; k++) {
      int ck1 = 0;
      for (int i = 0; i <= k; i++) {
        ck1 += this.coefficients[i] * b.coefficients[k - i];
      }
      int ck2 = 0;
      for (int i = k + 1; i < N; i++) {
        ck2 += this.coefficients[i] * b.coefficients[k + N - i];
      }
      int ck = c.coefficients[k] + ck1 + ck2;
      c.coefficients[k] = ck & (mod - 1);
    }
    return c;
  }

  Polynomial multPolyModInt(Polynomial b, int mod) {
    int N = this.N;
    Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
    for (int k = 0; k < N; k++) {
      int ck1 = 0;
      for (int i = 0; i <= k; i++) {
        ck1 += this.coefficients[i] * b.coefficients[k - i];
      }
      int ck2 = 0;
      for (int i = k + 1; i < N; i++) {
        ck2 += this.coefficients[i] * b.coefficients[k + N - i];
      }
      int ck = c.coefficients[k] + ck1 + ck2;
      c.coefficients[k] = ck % mod;
    }
    return c;
  }

  Polynomial multPolyMod3(Polynomial b) {
    int N = this.N;
    Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
    for (int k = 0; k < N; k++) {
      int ck1 = 0;
      for (int i = 0; i <= k; i++) {
        ck1 += this.coefficients[i] * b.coefficients[k - i];
      }
      int ck2 = 0;
      for (int i = k + 1; i < N; i++) {
        ck2 += this.coefficients[i] * b.coefficients[k + N - i];
      }
      int ck = c.coefficients[k] + ck1 + ck2;
      c.coefficients[k] = ck % 3;
    }
    return c;
  }

  Polynomial multPolyMod2048(Polynomial b) {
    int N = this.N;
    Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
    for (int k = 0; k < N; k++) {
      int ck1 = 0;
      for (int i = 0; i <= k; i++) {
        ck1 += this.coefficients[i] * b.coefficients[k - i];
      }
      int ck2 = 0;
      for (int i = k + 1; i < N; i++) {
        ck2 += this.coefficients[i] * b.coefficients[k + N - i];
      }
      int ck = c.coefficients[k] + ck1 + ck2;
      c.coefficients[k] = ck % 2048;
    }
    return c;
  }

  Polynomial multPolyModCenterLiftPowerOfTwo(Polynomial b, int mod) {
    int N = this.N;
    Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
    for (int k = 0; k < N; k++) {
      int ck1 = 0;
      for (int i = 0; i <= k; i++) {
        ck1 += this.coefficients[i] * b.coefficients[k - i];
      }
      int ck2 = 0;
      for (int i = k + 1; i < N; i++) {
        ck2 += this.coefficients[i] * b.coefficients[k + N - i];
      }
      int ck = c.coefficients[k] + ck1 + ck2;
      c.coefficients[k] = modCenterLiftModPowerOfTwo(ck, mod);
    }
    return c;
  }

  Polynomial multPolyModCenterLiftInt(Polynomial b, int mod) {
    int N = this.N;
    Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
    for (int k = 0; k < N; k++) {
      int ck1 = 0;
      for (int i = 0; i <= k; i++) {
        ck1 += this.coefficients[i] * b.coefficients[k - i];
      }
      int ck2 = 0;
      for (int i = k + 1; i < N; i++) {
        ck2 += this.coefficients[i] * b.coefficients[k + N - i];
      }
      int ck = c.coefficients[k] + ck1 + ck2;
      c.coefficients[k] = modCenterLiftModInt(ck, mod);
    }
    return c;
  }

  Polynomial multPolyModCenterLift3(Polynomial b) {
    int N = this.N;
    Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
    for (int k = 0; k < N; k++) {
      int ck1 = 0;
      for (int i = 0; i <= k; i++) {
        ck1 += this.coefficients[i] * b.coefficients[k - i];
      }
      int ck2 = 0;
      for (int i = k + 1; i < N; i++) {
        ck2 += this.coefficients[i] * b.coefficients[k + N - i];
      }
      int ck = c.coefficients[k] + ck1 + ck2;
      c.coefficients[k] = modCenterLiftMod3(ck);
    }
    return c;
  }

  Polynomial multPolyModCenterLift2048(Polynomial b) {
    int N = this.N;
    Polynomial c = Polynomial.fromDegree(N, d: 0, coeff: 0);
    for (int k = 0; k < N; k++) {
      int ck1 = 0;
      for (int i = 0; i <= k; i++) {
        ck1 += this.coefficients[i] * b.coefficients[k - i];
      }
      int ck2 = 0;
      for (int i = k + 1; i < N; i++) {
        ck2 += this.coefficients[i] * b.coefficients[k + N - i];
      }
      int ck = c.coefficients[k] + ck1 + ck2;
      c.coefficients[k] = modCenterLiftMod2048(ck);
    }
    return c;
  }

  Polynomial addIntModInt(int b, int mod) {
    List<int> result = List.from(this._coefficients);
    result[result.length - 1] = (result[result.length - 1] + b) % mod;

    return Polynomial(this._N, result);
  }

  Polynomial addIntMod3(int b) {
    List<int> result = List.from(this._coefficients);
    result[result.length - 1] = (result[result.length - 1] + b) % 3;

    return Polynomial(this._N, result);
  }

  Polynomial addPolyModInt(Polynomial b, int mod) {
    Polynomial c = Polynomial.fromDegree(this.N, d: 0, coeff: 0);
    for (int i = 0; i < this.N; i++)
      c.coefficients[i] = (this.coefficients[i] + b.coefficients[i]) % mod;
    return c;
  }

  Polynomial addPolyMod2048(Polynomial b) {
    Polynomial c = Polynomial.fromDegree(this.N, d: 0, coeff: 0);
    for (int i = 0; i < this.N; i++)
      c.coefficients[i] = (this.coefficients[i] + b.coefficients[i]) % 2048;
    return c;
  }

  Polynomial addPolyModPowerOfTwo(Polynomial b, int mod) {
    Polynomial c = Polynomial.fromDegree(this.N, d: 0, coeff: 0);
    for (int i = 0; i < this.N; i++)
      c.coefficients[i] =
          (this.coefficients[i] + b.coefficients[i]) & (mod - 1);
    return c;
  }

  Polynomial substractPoly(Polynomial b, int modulo) {
    Polynomial c = Polynomial.fromDegree(this.N, d: 0, coeff: 0);
    for (int i = 0; i < this.N; i++)
      c.coefficients[i] = (this.coefficients[i] - b.coefficients[i]) % modulo;
    return c;
  }

  Polynomial substractPolyModInt(Polynomial b, int mod) {
    Polynomial c = Polynomial.fromDegree(this.N, d: 0, coeff: 0);
    for (int i = 0; i < this.N; i++)
      c.coefficients[i] = (this.coefficients[i] - b.coefficients[i]) % mod;
    return c;
  }

  Polynomial reduce(int p) {
    return Polynomial(
        this._N, this._coefficients.map((elem) => elem % p).toList());
  }

  int modCenterLiftModInt(int a, int mod) {
    int tmpResult = (mod + a) % mod;
    int tmpResult2 = tmpResult - mod;
    if (tmpResult2 * tmpResult2 < tmpResult * tmpResult) {
      return tmpResult - mod;
    }
    return tmpResult;
  }

  int modCenterLiftModPowerOfTwo(int a, int mod) {
    int tmpResult = (mod + a) & (mod - 1);
    int tmpResult2 = tmpResult - mod;
    if (tmpResult2 * tmpResult2 < tmpResult * tmpResult) {
      return tmpResult - mod;
    }
    return tmpResult;
  }

  int modCenterLiftMod3(int a) {
    int tmpResult = (3 + a) % 3;
    int tmpResult2 = tmpResult - 3;
    if (tmpResult2 * tmpResult2 < tmpResult * tmpResult) {
      return tmpResult - 3;
    }
    return tmpResult;
  }

  int modCenterLiftMod2048(int a) {
    int tmpResult = (2048 + a) % 2048;
    int tmpResult2 = tmpResult - 2048;
    if (tmpResult2 * tmpResult2 < tmpResult * tmpResult) {
      return tmpResult - 2048;
    }
    return tmpResult;
  }

  bool isZero() {
    return this._coefficients[0] == 0 && this.getDegree() == 0;
  }

  bool isOne() {
    return this._coefficients[0] == 1 && this.getDegree() == 0;
  }

  int getDegree() {
    for (int i = this._coefficients.length - 1; i >= 0; i--) {
      if (this._coefficients[i] != 0) return i;
    }
    return 0;
  }

  String encodeCoefficientsToCommaSeparatedValue() {
    return this._coefficients.map((i) => i.toString()).join(",");
  }
}
