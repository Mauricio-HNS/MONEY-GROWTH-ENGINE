import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final PageController _pages;
  late final AnimationController _motion;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pages = PageController();
    _motion = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pages.dispose();
    _motion.dispose();
    super.dispose();
  }

  void _continue() {
    if (_index < 2) {
      _pages.nextPage(
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pages,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (value) => setState(() => _index = value),
        children: [
          _EditorialSplash(
            motion: _motion,
            background: const Color(0xFFB94A58),
            secondary: const Color(0xFFE9BFC3),
            foreground: const Color(0xFFF8E9E4),
            eyebrow: '01  /  MONEY',
            title: const ['KNOW', 'YOUR', 'MONEY.'],
            description:
                'See your financial life clearly before making your next move.',
            pose: _PersonPose.forward,
          ),
          _EditorialSplash(
            motion: _motion,
            background: const Color(0xFFE4C9B8),
            secondary: const Color(0xFFB98B7D),
            foreground: const Color(0xFF4A292D),
            eyebrow: '02  /  CLARITY',
            title: const ['FIND', 'WHAT', 'MATTERS.'],
            description:
                'Turn scattered numbers into a simple picture of what comes next.',
            pose: _PersonPose.side,
          ),
          _EditorialSplash(
            motion: _motion,
            background: const Color(0xFF403238),
            secondary: const Color(0xFFC98D91),
            foreground: const Color(0xFFF6E8DF),
            eyebrow: '03  /  GROW',
            title: const ['MAKE', 'YOUR', 'NEXT MOVE.'],
            description:
                'Analyze. Plan. Grow. Build momentum one decision at a time.',
            pose: _PersonPose.confident,
            finalPage: true,
            onContinue: _continue,
          ),
        ],
      ),
    );
  }
}

enum _PersonPose { forward, side, confident }

class _EditorialSplash extends StatelessWidget {
  const _EditorialSplash({
    required this.motion,
    required this.background,
    required this.secondary,
    required this.foreground,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.pose,
    this.finalPage = false,
    this.onContinue,
  });

  final Animation<double> motion;
  final Color background;
  final Color secondary;
  final Color foreground;
  final String eyebrow;
  final List<String> title;
  final String description;
  final _PersonPose pose;
  final bool finalPage;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: motion,
      builder: (context, _) {
        final drift = math.sin(motion.value * math.pi) * 8;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                background,
                Color.lerp(background, secondary, .45)!,
                background,
              ],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: _EditorialBackgroundPainter(
                  accent: secondary,
                  progress: motion.value,
                ),
              ),

              Positioned(
                top: -35 + drift,
                right: -30,
                child: _SoftOrb(
                  size: 220,
                  color: secondary.withValues(alpha: .32),
                ),
              ),

              Positioned(
                top: MediaQuery.sizeOf(context).height * .06 + drift,
                right: -35,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * .78,
                  height: MediaQuery.sizeOf(context).height * .62,
                  child: CustomPaint(
                    painter: _ElegantPersonPainter(
                      color: foreground,
                      secondary: secondary,
                      pose: pose,
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 26, 28, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eyebrow,
                        style: TextStyle(
                          color: foreground.withValues(alpha: .72),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.8,
                        ),
                      ),
                      const Spacer(flex: 5),
                      Text(
                        title.join('\n'),
                        style: TextStyle(
                          color: foreground,
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          height: .87,
                          letterSpacing: -2.6,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .72,
                        child: Text(
                          description,
                          style: TextStyle(
                            color: foreground.withValues(alpha: .78),
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      Row(
                        children: [
                          ...List.generate(
                            3,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 7),
                              width: i == title.length - 3 ? 28 : 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: foreground.withValues(
                                  alpha: i == title.length - 3 ? 1 : .28,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (finalPage)
                            FilledButton(
                              onPressed: onContinue,
                              style: FilledButton.styleFrom(
                                backgroundColor: foreground,
                                foregroundColor: background,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'CONTINUE',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            )
                          else
                            TextButton(
                              onPressed: onContinue,
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                  color: foreground,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SoftOrb extends StatelessWidget {
  const _SoftOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .22),
            blurRadius: 80,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}

class _EditorialBackgroundPainter extends CustomPainter {
  const _EditorialBackgroundPainter({
    required this.accent,
    required this.progress,
  });

  final Color accent;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = accent.withValues(alpha: .14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (var i = 0; i < 7; i++) {
      final path = Path();
      final y = size.height * (.18 + i * .105);
      path.moveTo(-30, y);
      path.cubicTo(
        size.width * .28,
        y - 60,
        size.width * .56,
        y + 50,
        size.width + 40,
        y - 20,
      );
      canvas.drawPath(path, paint);
    }

    final line = Paint()
      ..color = accent.withValues(alpha: .10)
      ..strokeWidth = 2;

    final x = size.width * (.10 + progress * .12);
    canvas.drawLine(
      Offset(x, size.height * .72),
      Offset(x + 100, size.height * .55),
      line,
    );
  }

  @override
  bool shouldRepaint(covariant _EditorialBackgroundPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _ElegantPersonPainter extends CustomPainter {
  const _ElegantPersonPainter({
    required this.color,
    required this.secondary,
    required this.pose,
  });

  final Color color;
  final Color secondary;
  final _PersonPose pose;

  @override
  void paint(Canvas canvas, Size size) {
    final s = math.min(size.width, size.height) / 430;
    canvas.save();
    canvas.scale(s);

    final skin = secondary.withValues(alpha: .92);
    final garment = color.withValues(alpha: .96);
    final soft = color.withValues(alpha: .42);

    // Head.
    final head = Paint()..color = skin;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(255, 88),
        width: 72,
        height: 92,
      ),
      head,
    );

    // Hair / silhouette.
    final hair = Paint()..color = garment;
    final hairPath = Path()
      ..moveTo(218, 83)
      ..quadraticBezierTo(220, 30, 264, 32)
      ..quadraticBezierTo(304, 35, 300, 82)
      ..quadraticBezierTo(278, 58, 246, 64)
      ..quadraticBezierTo(233, 72, 218, 83)
      ..close();
    canvas.drawPath(hairPath, hair);

    // Neck.
    canvas.drawRect(
      const Rect.fromLTWH(242, 126, 29, 42),
      Paint()..color = skin,
    );

    // Body / flowing editorial garment.
    final body = Path()
      ..moveTo(232, 150)
      ..quadraticBezierTo(195, 170, 180, 235)
      ..quadraticBezierTo(166, 315, 185, 408)
      ..lineTo(330, 408)
      ..quadraticBezierTo(339, 318, 314, 225)
      ..quadraticBezierTo(299, 171, 274, 150)
      ..close();
    canvas.drawPath(body, Paint()..color = garment);

    // Shoulder highlight.
    final highlight = Paint()
      ..color = soft
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      const Rect.fromLTWH(193, 158, 116, 110),
      math.pi * .05,
      math.pi * .72,
      false,
      highlight,
    );

    // Arms vary by pose.
    final arm = Paint()
      ..color = skin
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    switch (pose) {
      case _PersonPose.forward:
        canvas.drawLine(
          const Offset(207, 184),
          const Offset(144, 268),
          arm,
        );
        canvas.drawLine(
          const Offset(303, 184),
          const Offset(343, 265),
          arm,
        );
      case _PersonPose.side:
        canvas.drawLine(
          const Offset(214, 185),
          const Offset(147, 215),
          arm,
        );
        canvas.drawLine(
          const Offset(296, 185),
          const Offset(323, 285),
          arm,
        );
      case _PersonPose.confident:
        canvas.drawLine(
          const Offset(211, 185),
          const Offset(151, 130),
          arm,
        );
        canvas.drawLine(
          const Offset(301, 185),
          const Offset(354, 235),
          arm,
        );
    }

    // Legs.
    final leg = Paint()
      ..color = garment
      ..style = PaintingStyle.stroke
      ..strokeWidth = 38
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      const Offset(225, 388),
      Offset(
        pose == _PersonPose.side ? 210 : 205,
        520,
      ),
      leg,
    );
    canvas.drawLine(
      const Offset(285, 388),
      Offset(
        pose == _PersonPose.confident ? 326 : 300,
        520,
      ),
      leg,
    );

    // Minimal shoes.
    final shoe = Paint()
      ..color = color.withValues(alpha: .98)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(190, 520), const Offset(220, 520), shoe);
    canvas.drawLine(const Offset(298, 520), const Offset(332, 520), shoe);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ElegantPersonPainter oldDelegate) =>
      oldDelegate.pose != pose ||
      oldDelegate.color != color ||
      oldDelegate.secondary != secondary;
}
