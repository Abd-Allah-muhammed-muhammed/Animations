import 'dart:math';

import 'package:flutter/material.dart';



void main() {
  runApp(
    MyApp(),

  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedGradientBox',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      home: AnimatedGradientBox(
        width: 200,
        height: 200,
        colors: [Color(0xFFFA8072), Color(0xFF00CED1), Color(0xFFF08080)],

        isRepeating: true,
      ),
    );
  }
}


class AnimatedGradientBox extends StatefulWidget {
  final double width;
  final double height;
  final List<Color> colors;
  final bool isRepeating;
  final int duration;

  const AnimatedGradientBox({
    Key? key,
    required this.width,
    required this.height,
    required this.colors,
    this.isRepeating = false,
    this.duration = 2000,
  }) : super(key: key);

  @override
  _AnimatedGradientBoxState createState() => _AnimatedGradientBoxState();
}

class _AnimatedGradientBoxState extends State<AnimatedGradientBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    if (widget.isRepeating) {
      _controller.repeat();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, _animation.value, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        );
      },
    );
  }
}
