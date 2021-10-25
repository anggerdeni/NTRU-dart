import '../library/ntru.dart'; // method 2

String benchmark_ntru_2(int count) {
  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    new NTRU();
  }
  return '${stopwatch.elapsed}';
}

void main() {
  for (int i = 0; i < 10; i++) {
    print('#############################');
    print(benchmark_ntru_2(10000));
    print('----------------');
  }
}
