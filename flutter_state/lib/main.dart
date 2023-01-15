import 'package:flutter/material.dart';
import 'package:flutter_state/counter_model.dart';
import 'package:provider/provider.dart';

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
      home: Provider<CounterModel>(
        create: (context) => CounterModel(),
        child: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
            CounterWidget(),
            PressMeButton(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final counterModel = Provider.of<CounterModel>(context);

    return Column(
      children: [
        Text('${counterModel.currentValue}'),
      ],
    );
  }
}

class PressMeButton extends StatefulWidget {
  const PressMeButton({
    super.key,
  });

  @override
  State<PressMeButton> createState() => _PressMeButtonState();
}

class _PressMeButtonState extends State<PressMeButton> {
  @override
  Widget build(BuildContext context) {
    final counterModel = Provider.of<CounterModel>(context);

    return TextButton(
      onPressed: () {
        counterModel.increment(by: 1);
      },
      child: Text(
        'Press me Current value ${counterModel.currentValue}',
      ),
    );
  }
}
