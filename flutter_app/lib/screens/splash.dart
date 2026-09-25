import 'package:flutter/material.dart';

import '../routes.dart';
import '../style/app_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkKnight,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.laguna, AppColors.coldBlue]),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(Icons.auto_graph_rounded, size: 48, color: AppColors.darkKnight),
              ),
              const SizedBox(height: 28),
              const Text('MONEY GROWTH ENGINE', textAlign: TextAlign.center, style: TextStyle(color: AppColors.white, fontSize: 23, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
              const SizedBox(height: 10),
              const Text('Your financial recovery and growth engine.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
              const SizedBox(height: 34),
              const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.laguna)),
            ],
          ),
        ),
      ),
    );
  }
}
