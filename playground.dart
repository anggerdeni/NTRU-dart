void main() {
  int count = 1000000;
  int res;
  var stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    res = 3 % 2048;
  }
  print('Ordinary mod (%) ${stopwatch.elapsed}');

  stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    res = 3 & 2047;
  }
  print('Bit operation mod ${stopwatch.elapsed}');
}