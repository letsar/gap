import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const <Widget>[
            _Section(
              title: 'Gap inside a WidgetSpan (#27)',
              child: _RichTextExample(),
            ),
            _Section(
              title: 'Gap inside a horizontal Wrap (#22)',
              child: _WrapExample(direction: Axis.horizontal),
            ),
            _Section(
              title: 'Gap inside a vertical Wrap',
              child: SizedBox(
                height: 200,
                child: _WrapExample(direction: Axis.vertical),
              ),
            ),
            _Section(
              title: 'Gap inside a Wrap with text (#22)',
              child: _WrapWithTextExample(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const Gap(8),
        DecoratedBox(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: child,
          ),
        ),
        const Gap(24),
      ],
    );
  }
}

class _RichTextExample extends StatelessWidget {
  const _RichTextExample();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'Online',
        style: TextStyle(color: Color(0xff0AAC80), fontSize: 20),
        children: <InlineSpan>[
          TextSpan(
            text: '/Total',
            style: TextStyle(color: Color(0xff2B3133)),
          ),
          WidgetSpan(
            child: Gap(40, crossAxisExtent: 20, color: Colors.red),
          ),
          TextSpan(text: '0'),
          TextSpan(
            text: '/0',
            style: TextStyle(color: Color(0xff2B3133)),
          ),
        ],
      ),
    );
  }
}

class _WrapExample extends StatelessWidget {
  const _WrapExample({
    required this.direction,
  });

  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: direction,
      runSpacing: 16,
      children: const <Widget>[
        _Box(color: Colors.green),
        Gap(10, crossAxisExtent: 40, color: Colors.red),
        _Box(color: Colors.yellow),
        Gap(30, crossAxisExtent: 40, color: Colors.red),
        _Box(color: Colors.blue),
        Gap(10, crossAxisExtent: 40, color: Colors.red),
        _Box(color: Colors.green),
        Gap(30, crossAxisExtent: 40, color: Colors.red),
        _Box(color: Colors.yellow),
        Gap(10, crossAxisExtent: 40, color: Colors.red),
        _Box(color: Colors.blue),
      ],
    );
  }
}

class _WrapWithTextExample extends StatelessWidget {
  const _WrapWithTextExample();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Text('Message', style: TextStyle(color: Colors.black54)),
        Gap(5),
        Icon(Icons.circle_rounded, size: 8, color: Colors.black54),
        Gap(5),
        Text(
          'A long message that should wrap on small screens',
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(width: 40, height: 40, color: color);
  }
}
