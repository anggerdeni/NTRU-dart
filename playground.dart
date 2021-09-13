void main() {
  int x = 0;
  var stopwatch = Stopwatch()..start();
  for (int i = 0; i < 50000; i++) {
  }
  print('New method ${stopwatch.elapsed}');
  stopwatch = Stopwatch()..start();
  for (int i = 0; i < 50000; i++) {
  }
  print('Old method ${stopwatch.elapsed}');
}