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

class HomePage extends StatefulWidget {
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
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    height: 50,
                  ),
                  AnimatedGap(
                    extent,
                    crossAxisExtent: extent / 2,
                    color: () {
                      if (extent == 0) {
                        return Colors.transparent;
                      } else if (extent == 50) {
                        return Colors.black;
                      } else if (extent == 100) {
                        return Colors.amber;
                      }

                      return Colors.teal;
                    }(),
                    duration: const Duration(milliseconds: 250),
                  ),
                  Row(
                    children: [
                      Container(
                        color: Colors.green,
                        width: 50,
                        height: 50,
                      ),
                      AnimatedGap(
                        extent,
                        duration: const Duration(milliseconds: 250),
                      ),
                      Container(
                        color: Colors.green,
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                  AnimatedGap(
                    extent,
                    duration: const Duration(milliseconds: 250),
                  ),
                  Container(
                    color: Colors.blue,
                    height: 50,
                  ),
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
