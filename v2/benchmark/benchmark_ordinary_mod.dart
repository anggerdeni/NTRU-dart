void main() {
  int count = 100000*100000;

  var stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    1342 % 2048;
  }
  print('Ordinary mod  ${count} operation: ${stopwatch.elapsed}');
}