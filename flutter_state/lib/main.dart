import 'package:flutter/material.dart';
import 'package:flutter_state/counter_interactor.dart';
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
  final interactor = CounterInteractor();

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
            CounterWidget(interactor: interactor),
            PressMeButton(interactor: interactor),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    interactor.dispose();
    super.dispose();
  }
}

class CounterWidget extends StatelessWidget {
  final CounterInteractor interactor;

  const CounterWidget({
    super.key,
    required this.interactor,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: interactor.output,
      builder: (context, snapshot) {
        return Column(
          children: [
            Text('${snapshot.data?.currentValue ?? 0}'),
          ],
        );
      },
    );
  }
}

class PressMeButton extends StatelessWidget {
  final CounterInteractor interactor;

  const PressMeButton({
    super.key,
    required this.interactor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        interactor.input.add(
          CounterInteractorIncrementBy(1),
        );
      },
      child: StreamBuilder(
        stream: interactor.output,
        builder: (context, snapshot) {
          return Text(
            'Press me Current value ${snapshot.data?.currentValue ?? 0}',
          );
        },
      ),
    );
  }
}
