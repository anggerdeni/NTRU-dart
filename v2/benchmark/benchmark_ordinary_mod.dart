void main() {
  int count = 1000000;
  int res = 0;

  var stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    res = 1342 % 2048;
  }
  print('Ordinary mod  ${count} operation: ${stopwatch.elapsed}');
}