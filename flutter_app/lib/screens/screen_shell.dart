import 'package:flutter/material.dart';

import '../routes.dart';
import '../style/app_style.dart';
import '../style/brand.dart';

class ScreenShell extends StatelessWidget {
  const ScreenShell({required this.title, required this.child, super.key});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 66,
        leading: const Padding(padding: EdgeInsets.only(left: 14), child: BrandMark(size: 42, borderRadius: 13)),
        title: Text(title.toUpperCase()),
        actions: [
          IconButton(tooltip: 'Opportunity Radar', onPressed: () => Navigator.pushNamed(context, AppRoutes.radar), icon: const Icon(Icons.radar_rounded, color: AppColors.white)),
          const SizedBox(width: 6),
        ],
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: _ShellBackground()),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 88, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MONEY GROWTH ENGINE', style: TextStyle(color: AppColors.red.withValues(alpha: .9), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2.4)),
                  const SizedBox(height: 8),
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShellBackground extends StatelessWidget {
  const _ShellBackground();
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.redDark, AppColors.black, AppColors.black], stops: [0, .34, 1]),
    ),
    child: CustomPaint(painter: _ShellLinesPainter()),
  );
}

class _ShellLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: .055)..strokeWidth = 1.5..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    for (var i = 0; i < 6; i++) {
      final y = size.height * (.12 + i * .12);
      final path = Path()..moveTo(-40, y + 45)..lineTo(size.width * .35, y)..lineTo(size.width * .68, y + 25)..lineTo(size.width + 40, y - 55);
      canvas.drawPath(path, paint);
    }
  }
  @override
  bool shouldRepaint(covariant _ShellLinesPainter oldDelegate) => false;
}

class SectionCard extends StatelessWidget {
  const SectionCard({required this.title, required this.child, super.key});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.surface.withValues(alpha: .92),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: AppColors.border),
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .22), blurRadius: 24, offset: const Offset(0, 12))],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 14),
      child,
    ]),
  );
}

class AgentActionButton extends StatelessWidget {
  const AgentActionButton({required this.label, required this.onPressed, super.key});
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => FilledButton.icon(onPressed: onPressed, icon: const Icon(Icons.arrow_forward_rounded, size: 17), label: Text(label));
}
