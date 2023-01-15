import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _counter = 0;

  CounterModel();

  int get currentValue => _counter;

  void increment({required int by}) {
    _counter += by;
    notifyListeners();
  }
}
