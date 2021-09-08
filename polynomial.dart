import 'dart:math';

class Polynomial {
  int _N;
  List<int> _coefficients = [];

  Polynomial(this._N, this._coefficients);

  Polynomial.fromDegree(this._N, { required d, coeff }) {
    if(d >= this._N) throw Exception('Data length should be less than or equal to N');
    this._coefficients = new List.filled(this._N, 0);
    if(coeff != null) this._coefficients[d] = coeff;
    else this._coefficients[d] = 1;
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

  Polynomial operator+(Polynomial secondPolynomial) {
    if(this._N != secondPolynomial.N) throw new Exception('The two polynomials should have the same N');
    List<int> result = List<int>.from(this._coefficients);
    List<int> secondData = List<int>.from(secondPolynomial.coefficients);
    
    for (int i = 0; i < secondData.length; i += 1) {
      result[i] += secondData[i];
    }

    return Polynomial(this._N, result);
  }

  Polynomial operator-(Polynomial secondPolynomial) {
    if(this._N != secondPolynomial.N) throw new Exception('The two polynomials should have the same N');
    List<int> original = List<int>.from(this._coefficients);
    List<int> pengurang = List<int>.from(secondPolynomial.coefficients);
    
    for (int i = 0; i < pengurang.length; i += 1) {
      original[i] -= pengurang[i];
    }

    return Polynomial(this._N, original);
  }

  Polynomial operator*(Polynomial secondPolynomial) {
    if(this._N != secondPolynomial.N) throw new Exception('The two polynomials should have the same N');
    List<int> result = new List.filled(this._N, 0);
    
    for (int i = 0; i < this._coefficients.length; i += 1) {
      for (int j = 0; j < secondPolynomial.coefficients.length; j += 1) {
        result[(i+j) % this._N] += this._coefficients[i] * secondPolynomial.coefficients[j];
      }
    }

    return Polynomial(this._N, result);
  }

  Polynomial multiplyInt(int b) {
    List<int> result = [];
    
    for (int i = 0; i < this._coefficients.length; i += 1) {
      result.add(this._coefficients[i] * b);
    }

    return Polynomial(this._N, result);
  }

  Polynomial addInt(int b) {
    List<int> result = List.from(this._coefficients);
    result[result.length - 1] += b;
    
    return Polynomial(this._N, result);
  }

  Polynomial multiplyReducePower(Polynomial secondPolynomial) {
    Polynomial tmp = this * secondPolynomial;
    return tmp.reducePower();
  }

  List<Polynomial> div(Polynomial secondPolynomial, int p) {
    Polynomial r = this.clone();
    Polynomial q = Polynomial(this._N, new List.filled(this._N, 0));

    int secondPolynomialDegree = secondPolynomial.getDegree();
    int u = secondPolynomial.getCoeffisienOfDegree(secondPolynomialDegree).modInverse(p);
    int d;
    
    Polynomial v;
    while(r.getDegree() >= secondPolynomialDegree && !r.isZero()) {
      d = r.getDegree();
      v = Polynomial.fromDegree(this._N, d: (d - secondPolynomialDegree), coeff: u * (r.getCoeffisienOfDegree(d)));
      r = (r - v * secondPolynomial).reduce(p);
      q = (q + v).reduce(p);
    }

    return [q,r];
  }

  Polynomial reduce(int p) {
    List<int> result = this._coefficients.map((elem) => elem%p).toList();
    return Polynomial(this._N, result);
  }

  Polynomial reduceCenterLift(int p) {
    List<int> result = this._coefficients.map((elem) => modCenterLift(elem, p)).toList();
    return Polynomial(this._N, result);
  }

  Polynomial reducePower() {
    List<int> coeff = List.filled(this._N, 0);
    for (int i = 0; i < this.coefficients.length; i++) {
      coeff[i%this._N] += this.coefficients[i];
    }
    return Polynomial(this._N, coeff);
  }

  int modCenterLift(int a, int b) {
      int tmpResult = (b + (a%b)) % b;
      if(pow((tmpResult - b),2) < pow(tmpResult, 2)) {
          return tmpResult - b;
      }
      return tmpResult;
  }

  Polynomial clone() {
    return Polynomial(this._N, List.from(this._coefficients));
  }

  bool isZero() {
    return this.getDegree() == 0 && this.getCoeffisienOfDegree(0) == 0;
  }

  bool isOne() {
    return this.getDegree() == 0 && this.getCoeffisienOfDegree(0) == 1;
  }

  int getDegree() {
    for (int i = this._coefficients.length - 1; i >= 0; i--) {
      if(this._coefficients[i] != 0) return i;
    }
    return 0;
  }

  int getCoeffisienOfDegree(int degree) {
    if(degree > this.getDegree()) throw Exception('Degree cannot be greater than polynomial degree');
    return this._coefficients[degree];
  }
}