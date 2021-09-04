import 'polynomial.dart';

void main() {
  Polynomial p1 = Polynomial([1,1]);
  Polynomial p2 = Polynomial([1,0,2,1]);
  Polynomial p3 = p1 * p2;
  
  List<Polynomial>test = p3.div(p2, 3);

  // print(test[0].coefficients);
}