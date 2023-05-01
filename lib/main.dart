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
      title: 'particle background animation',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      home: ParticleBackground(
        backgroundColor: Colors.black,
      ),
    );
  }
}

class ParticleBackground extends StatefulWidget {
  final Color backgroundColor;

  ParticleBackground({this.backgroundColor = Colors.black});

  @override
  _ParticleBackgroundState createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..addListener(() {
      setState(() {
        particles.removeWhere((particle) => particle.isDead);
        for (var particle in particles) {
          particle.update();
        }
      });
    });

    _controller.repeat();
    _createParticles();
  }

  void _createParticles() {
    for (var i = 0; i < 100; i++) {
      particles.add(Particle());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: CustomPaint(
        painter: ParticlePainter(particles: particles),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  double x = 0.0;
  double y = 0.0;
  double dx = 0.0;
  double dy = 0.0;
  double radius = 0.0;
  double life = 0.0;
  double maxLife = 0.0;

  bool get isDead => life <= 0.0;

  Particle() {
    _reset();
  }

  void _reset() {
    x = 0.0;
    y = 0.0;
    dx = -1.0 + Random().nextDouble() * 2.0;
    dy = -1.0 + Random().nextDouble() * 2.0;
    radius = 1.0 + Random().nextDouble() * 4.0;
    maxLife = 20.0 + Random().nextDouble() * 40.0;
    life = maxLife;
  }

  void update() {
    x += dx;
    y += dy;
    life -= 0.6;
    if (isDead) _reset();
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Paint _paint = Paint()..style = PaintingStyle.fill;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    particles.forEach((particle) {
      _paint.color = HSLColor.fromAHSL(
        1.0,
        (particle.life / particle.maxLife) * 300.0,
        1.0,
        0.5,
      ).toColor();

      canvas.drawCircle(
        Offset(
          size.width / 2 + particle.x * 10,
          size.height / 2 + particle.y * 10,
        ),
        particle.radius,
        _paint,
      );
    });
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
