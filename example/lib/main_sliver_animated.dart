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
class HomePage extends StatefulWidget {
  /// Creates a [HomePage].
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double extent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const _SliverBox(color: Colors.green),
                  SliverAnimatedGap(
                    extent,
                    duration: const Duration(milliseconds: 250),
                  ),
                  const _SliverBox(color: Colors.red),
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  const _SliverBox(color: Colors.green),
                  SliverAnimatedGap(
                    extent,
                    duration: const Duration(milliseconds: 250),
                  ),
                  const _SliverBox(color: Colors.red),
                ],
              ),
            ),
            Slider(
              value: extent,
              max: 150,
              divisions: 3,
              label: extent.toString(),
              onChanged: (double value) {
                setState(() {
                  extent = value;
                });
              },
            ),
          ],
        ),
      ),
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
