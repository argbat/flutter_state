import 'package:flutter/material.dart';

class CounterModel extends ValueNotifier {
  int _counter = 0;

  CounterModel() : super(0);

  int get currentValue => _counter;

  void increment({required int by}) {
    _counter += by;
    notifyListeners();
  }
}
