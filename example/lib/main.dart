import 'package:flutter/material.dart';
import 'dart:async';

import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SimpleAnimationProgressBarTestPage(),
    );
  }
}

class SimpleAnimationProgressBarTestPage extends StatefulWidget {
  const SimpleAnimationProgressBarTestPage({super.key});

  @override
  State<SimpleAnimationProgressBarTestPage> createState() =>
      _SimpleAnimationProgressBarTestPageState();
}

class _SimpleAnimationProgressBarTestPageState
    extends State<SimpleAnimationProgressBarTestPage> {
  double ratio = 0;
  void startDemo() async {
    setState(() => ratio = 0);

    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 2), () {
        setState(() => ratio += 0.1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        startDemo();
      }),
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleAnimationProgressBar(
                height: 50,
                width: 400,
                backgroundColor: Colors.grey.shade800,
                foregrondColor: Colors.purple,
                glowColor: Colors.grey.shade800,
                ratio: ratio,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 2),
                borderRadius: BorderRadius.circular(24),
                gradientColor: const LinearGradient(
                  colors: [Colors.pink, Colors.purple],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
