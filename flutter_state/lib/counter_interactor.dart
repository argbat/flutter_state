import 'dart:async';

import 'package:flutter_state/counter_model.dart';

abstract class CounterInteractorInput {}

class CounterInteractorIncrementBy extends CounterInteractorInput {
  final int by;

  CounterInteractorIncrementBy(this.by);
}

class CounterInteractor {
  final _counter = CounterModel();

  final _inputStreamController = StreamController<CounterInteractorInput>();
  StreamSink<CounterInteractorInput> get input => _inputStreamController.sink;

  final _outputStreamController = StreamController<CounterModel>.broadcast();
  Stream<CounterModel> get output => _outputStreamController.stream;

  CounterInteractor() {
    _inputStreamController.stream.listen(_handler);
  }

  void _handler(dynamic event) {
    if (event is CounterInteractorIncrementBy) {
      _increment(by: event.by);
      _outputStreamController.sink.add(_counter);
    }
  }

  void _increment({required int by}) {
    _counter.increment(by: by);
  }

  void dispose() {
    _outputStreamController.close();
    _inputStreamController.close();
  }
}
