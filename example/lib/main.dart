import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

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
          children: <Widget>[
            const Gap.expand(20, color: Colors.red),
            const Gap(80),
            const Gap.expand(20, color: Colors.red),
            const MaxGap(2000),
            const Gap.expand(20, color: Colors.red),
            Row(
              children: const <Widget>[
                Gap(20, color: Colors.green, crossAxisExtent: 20),
                Gap(50),
                Gap(20, color: Colors.green, crossAxisExtent: 20),
              ],
            ),
            const Gap.expand(200, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
