import 'package:flutter/material.dart';

class CounterModel {
  int _counter = 0;

  CounterModel();

  int get currentValue => _counter;

  void increment({required int by}) {
    _counter += by;
  }
}
