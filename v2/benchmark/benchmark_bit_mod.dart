void main() {
  int count = 1000000;
  int res = 0;

  var stopwatch = Stopwatch()..start();
  stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    res = 1342 & 2047;
  }
  print('Bit operation ${count} operation: ${stopwatch.elapsed}');
}