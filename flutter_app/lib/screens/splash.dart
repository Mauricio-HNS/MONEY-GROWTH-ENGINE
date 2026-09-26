import 'package:flutter/material.dart';

import '../routes.dart';
import '../style/brand.dart';

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

    Future.delayed(const Duration(milliseconds: 2200), () {
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
              Positioned.fill(
                child: Opacity(
                  opacity: .20,
                  child: BrandImage(fit: BoxFit.cover),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter: _MotionLinesPainter(progress: t),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(26, 24, 26, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const BrandMark(size: 48, borderRadius: 14),
                          const SizedBox(width: 12),
                          const Text(
                            'MONEY GROWTH\nENGINE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              height: 1,
                              letterSpacing: 1.8,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Transform.translate(
                        offset: Offset(0, 35 * (1 - t)),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * .39,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: .28),
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: .18),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: const BrandImage(fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Transform.translate(
                        offset: Offset(0, 30 * (1 - t)),
                        child: const Text(
                          'MONEY\nGROWTH\nENGINE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 43,
                            fontWeight: FontWeight.w900,
                            height: .86,
                            letterSpacing: -2.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'ANALYZE   /   PLAN   /   GROW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'YOUR MONEY. YOUR NEXT MOVE.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
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
      ..color = Colors.white.withValues(alpha: .10)
      ..strokeWidth = 2;

    for (var i = 0; i < 8; i++) {
      final y = size.height * (.18 + i * .085);
      final start = -size.width * .15 + progress * size.width * .12;
      canvas.drawLine(
        Offset(start, y),
        Offset(size.width * (.35 + i * .045), y - 35),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MotionLinesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
