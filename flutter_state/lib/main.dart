import 'package:flutter/material.dart';
import 'package:flutter_state/bloc.dart';
import 'package:flutter_state/counter_bloc.dart';

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
  final counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter State'),
      ),
      body: BlocProvider(
        bloc: counterBloc,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CounterWidget(),
              PressMeButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return StreamBuilder(
      stream: counterBloc.output,
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
  const PressMeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return TextButton(
      onPressed: () {
        counterBloc.input.add(
          CounterInteractorIncrementBy(1),
        );
      },
      child: StreamBuilder(
        stream: counterBloc.output,
        builder: (context, snapshot) {
          return Text(
            'Press me Current value ${snapshot.data?.currentValue ?? 0}',
          );
        },
      ),
    );
  }
}
