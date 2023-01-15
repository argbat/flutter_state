import 'package:flutter/material.dart';

abstract class Bloc {
  void dispose();
}

/// Help us to avoiding to passing down the instances of a provider.
class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({super.key, required this.bloc, required this.child});

  @override
  State<BlocProvider> createState() => _BlocProviderState();

  /// Let lower widgets find a provider avoiding to pass down the instances.
  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T>? provider = context.findAncestorWidgetOfExactType();
    assert(provider != null, 'No bloc provider found on the widget tree.');
    return provider!.bloc;
  }
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
