void main() {
  int count = 100000000;
  var stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    134 % 2048;
  }
  print('Ordinary mod  ${count} operation: ${stopwatch.elapsed}');

  var stopwatch2 = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    134 & 2047;
  }
  print('Bit operation ${count} operation: ${stopwatch2.elapsed}');
}