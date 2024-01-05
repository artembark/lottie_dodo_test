import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late final AnimationController _controller;
  int _previousFrame = 0;

  static const spots = [17, 35, 46, 60, 67, 74, 84, 88];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      final currentFrame = (_controller.value * 120).round();
      if (currentFrame != _previousFrame) {
        if (spots.contains(currentFrame)) {
          HapticFeedback.lightImpact();
        }

        _previousFrame = currentFrame;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange,
        body: Lottie.asset(
          'assets/new_year_splash_animation.json',
          controller: _controller,
          onLoaded: (composition) {
            setState(() {
              _controller.duration = composition.duration;
            });
            _controller
              ..forward()
              ..repeat();
          },
        ),
      ),
    );
  }
}
