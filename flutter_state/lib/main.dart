import 'package:flutter/material.dart';
import 'package:flutter_state/counter_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final CounterModel _counter = CounterModel();

  @override
  void initState() {
    super.initState();
    _counter.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter State'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CounterWidget(
              counter: _counter,
            ),
            PressMeButton(
              counter: _counter,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }
}

class CounterWidget extends StatelessWidget {
  final CounterModel _counter;

  const CounterWidget({
    super.key,
    required CounterModel counter,
  }) : _counter = counter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_counter.currentValue.toString()),
      ],
    );
  }
}

class PressMeButton extends StatefulWidget {
  final CounterModel _counter;

  const PressMeButton({
    super.key,
    required CounterModel counter,
  }) : _counter = counter;

  @override
  State<PressMeButton> createState() => _PressMeButtonState();
}

class _PressMeButtonState extends State<PressMeButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget._counter.increment(by: 1);
      },
      child: Text(
        'Press me Current value ${widget._counter.currentValue}',
      ),
    );
  }
}
