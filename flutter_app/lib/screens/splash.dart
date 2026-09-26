import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
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
    return Scaffold(
      backgroundColor: const Color(0xFFE50914),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = Curves.easeOutCubic.transform(_controller.value);
          return Stack(
            fit: StackFit.expand,
            children: [
              // Subtle editorial motion lines.
              Positioned.fill(
                child: CustomPaint(
                  painter: _MotionLinesPainter(progress: t),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'STRATEGY\nBUILDS WEALTH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 42,
                        height: 3,
                        color: Colors.white,
                      ),
                      const Spacer(),

                      // Large built-in runner: no external image or asset.
                      Transform.translate(
                        offset: Offset(42 * (1 - t), 0),
                        child: Transform.rotate(
                          angle: -0.055,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.directions_run_rounded,
                              size: 310,
                              color: Color(0xFF171717),
                            ),
                          ),
                        ),
                      ),

                      Transform.translate(
                        offset: Offset(0, 30 * (1 - t)),
                        child: const Text(
                          'MONEY\nGROWTH\nENGINE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 47,
                            fontWeight: FontWeight.w900,
                            height: 0.86,
                            letterSpacing: -2.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'ANALYZE   /   PLAN   /   GROW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.6,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Expanded(
                            child: Text(
                              'YOUR MONEY.\nYOUR NEXT MOVE.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                height: 1.35,
                                letterSpacing: 2.2,
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: -math.pi / 4,
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 38,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MotionLinesPainter extends CustomPainter {
  final double progress;

  const _MotionLinesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.11)
      ..strokeWidth = 2;

    for (var i = 0; i < 8; i++) {
      final y = size.height * (0.18 + i * 0.085);
      final start = -size.width * 0.15 + progress * size.width * 0.12;
      canvas.drawLine(
        Offset(start, y),
        Offset(size.width * (0.35 + i * 0.045), y - 35),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MotionLinesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
