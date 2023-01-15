class CounterModel {
  int _counter = 0;

  int get currentValue => _counter;

  void increment({required int by}) {
    _counter += by;
  }
}
