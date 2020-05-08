import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gap Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

/// A widget.
class HomePage extends StatelessWidget {
  /// Creates a [HomePage].
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            Expanded(child: _Body(axis: Axis.vertical)),
            Expanded(child: _Body(axis: Axis.horizontal)),
          ],
        ),
      ),
    );
  }
}

/// A widget.
class _Body extends StatelessWidget {
  /// Creates a [_Body].
  const _Body({
    Key key,
    this.axis,
  }) : super(key: key);

  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: axis,
      children: const <Widget>[
        _Gap(color: Colors.green),
        Gap(30, color: Colors.black),
        _Gap(color: Colors.red),
        _Gap(color: Colors.yellow),
        Gap(100),
        _Gap(color: Colors.green),
        _Gap(color: Colors.red),
        _Gap(color: Colors.yellow),
      ],
    );
  }
}

class _Gap extends StatelessWidget {
  const _Gap({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Gap(100, color: color);
  }
}
