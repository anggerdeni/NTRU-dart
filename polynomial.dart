class Polynomial {
  List<int> _coefficients = [];

  Polynomial(List<int> this._coefficients);

  Polynomial.fromDegree({ required d, coeff }) {
    this._coefficients = new List.filled(d, 0);
    if(coeff != null) this._coefficients[this._coefficients.length - 1] = coeff;
    else this._coefficients[this._coefficients.length - 1] = 1;
  }

  List<int> get coefficients {
    return this._coefficients;
  }

  set coefficients(List<int> coefficients) {
    this._coefficients = coefficients;
  }

  Polynomial operator+(Polynomial secondPolynomial) {
    List<int> greaterPolynom;
    List<int> smallerPolynom;
    if(this.getDegree() >= secondPolynomial.getDegree()) {
      greaterPolynom = List<int>.from(this._coefficients);
      smallerPolynom = List<int>.from(secondPolynomial.coefficients);
    } else {
      greaterPolynom = List<int>.from(secondPolynomial.coefficients);
      smallerPolynom = List<int>.from(this._coefficients);
    }

    List<int> result = List<int>.from(greaterPolynom);
    
    for (int i = 0; i < smallerPolynom.length; i += 1) {
      result[i] = smallerPolynom[i] + greaterPolynom[i];
    }

    return Polynomial(result);
  }

  Polynomial operator-(Polynomial secondPolynomial) {
    List<int> original = List<int>.from(this._coefficients);
    List<int> pengurang = List<int>.from(secondPolynomial.coefficients);

    if(original.length < pengurang.length) {
      original.addAll(new List.filled(pengurang.length - original.length, 0));
    } else if(pengurang.length < original.length) {
      pengurang.addAll(new List.filled(original.length - pengurang.length, 0));
    }

    List<int> result = new List.filled(original.length, 0);
    
    for (int i = 0; i < original.length; i += 1) {
      result[i] = original[i] - pengurang[i];
    }

    return Polynomial(result);
  }

  Polynomial operator*(Polynomial secondPolynomial) {
    List<int> result = new List.filled((this.getDegree() + secondPolynomial.getDegree()) + 1, 0);
    
    for (int i = 0; i <= this.getDegree(); i += 1) {
      for (int j = 0; j <= secondPolynomial.getDegree(); j += 1) {
        result[i+j] += this._coefficients[i] * secondPolynomial.coefficients[j];
      }
    }

    return Polynomial(result);
  }

  List<Polynomial> div(Polynomial secondPolynomial, int p) {
    Polynomial r = Polynomial(List<int>.from(this._coefficients));
    Polynomial q = Polynomial([0]);

    int secondPolynomialDegree = secondPolynomial.getDegree();
    int u = secondPolynomial.getCoeffisienOfDegree(secondPolynomialDegree).modInverse(p);
    int d;
    
    Polynomial v;
    int i = 0;
    while(r.getDegree() >= secondPolynomialDegree+1) {
      i += 1;
      d = r.getDegree();
      v = Polynomial.fromDegree(d: d, coeff: u * (r.getCoeffisienOfDegree(d)));
      r = r - (v * secondPolynomial);
      q = q + v;
      print(r.coefficients);
      print(q.coefficients);
      print(v.coefficients);
      print('---------------');
      if (i == 10) break;
    }

    return [q,r];
  }

  int getDegree() {
    for (int i = this._coefficients.length - 1; i >=0; i--) {
      if(this._coefficients[i] != 0) return i;
    }
    return 0;
  }

  int getCoeffisienOfDegree(int degree) {
    if(degree > this.getDegree()) throw Exception('Degree cannot be greater than polynomial degree');
    return this._coefficients[degree];
  }
}