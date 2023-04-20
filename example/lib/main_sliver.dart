import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

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
    Key? key,
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
    Key? key,
    required this.axis,
  }) : super(key: key);

  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: axis,
      slivers: const <Widget>[
        _SliverBox(color: Colors.green),
        SliverGap(30, color: Colors.black),
        _SliverBox(color: Colors.red),
        _SliverBox(color: Colors.yellow),
        SliverGap(100),
        _SliverBox(color: Colors.green),
        _SliverBox(color: Colors.red),
        _SliverBox(color: Colors.yellow),
      ],
    );
  }
}

class _SliverBox extends StatelessWidget {
  const _SliverBox({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: 100,
        height: 100,
        color: color,
      ),
    );
  }
}
