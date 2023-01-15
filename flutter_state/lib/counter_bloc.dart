import 'dart:async';

import 'package:flutter_state/bloc.dart';
import 'package:flutter_state/counter_model.dart';

abstract class CounterInteractorInput {}

class CounterInteractorIncrementBy implements CounterInteractorInput {
  final int by;

  CounterInteractorIncrementBy(this.by);
}

class CounterBloc implements Bloc {
  final _counter = CounterModel();

  final _inputStreamController = StreamController<CounterInteractorInput>();
  StreamSink<CounterInteractorInput> get input => _inputStreamController.sink;
  late final StreamSubscription<CounterInteractorInput> _inputSubscription;

  final _outputStreamController = StreamController<CounterModel>.broadcast();
  Stream<CounterModel> get output => _outputStreamController.stream;

  CounterBloc() {
    _inputSubscription = _inputStreamController.stream.listen(_handler);
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

  @override
  void dispose() {
    _outputStreamController.close();
    _inputSubscription.cancel();
    _inputStreamController.close();
  }
}
