import 'dart:ui';

import 'package:flutter/material.dart';

import '../routes.dart';
import '../style/app_style.dart';
import '../style/brand.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  static const _pages = <_OnboardingData>[
    _OnboardingData(
      number: '01',
      title: 'TAKE CONTROL.',
      text:
          'See exactly where your money comes from, where it goes, and what is slowing your progress.',
      icon: Icons.account_balance_wallet_rounded,
    ),
    _OnboardingData(
      number: '02',
      title: 'GET CLARITY.',
      text:
          'Organize income, expenses, debt, assets and investments in one financial command center.',
      icon: Icons.insights_rounded,
    ),
    _OnboardingData(
      number: '03',
      title: 'CREATE GROWTH.',
      text:
          'Turn your numbers into decisions, priorities and concrete actions for the next stage.',
      icon: Icons.auto_graph_rounded,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() {
    if (_page < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
      );
      return;
    }
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    final last = _page == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Subtle ambient glow tying the screen to the brand's red,
          // without covering or tinting any of the content on top of it.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.65),
                  radius: 1.1,
                  colors: [
                    AppColors.red.withValues(alpha: .16),
                    AppColors.black.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 14, 22, 0),
                  child: Row(
                    children: [
                      const BrandMark(size: 46, borderRadius: 14),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          BrandAssets.appName,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.8,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        ),
                        child: const Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageChanged: (value) => setState(() => _page = value),
                    itemBuilder: (_, index) => _OnboardingPage(
                      data: _pages[index],
                      active: index == _page,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
                  child: Column(
                    children: [
                      Row(
                        children: List.generate(
                          _pages.length,
                          (index) => Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 260),
                              height: 5,
                              margin: EdgeInsets.only(
                                right: index == _pages.length - 1 ? 0 : 6,
                              ),
                              decoration: BoxDecoration(
                                color: index == _page
                                    ? AppColors.red
                                    : AppColors.border,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton(
                          onPressed: _continue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(last ? 'CRIAR MINHA CONTA' : 'CONTINUAR'),
                              const SizedBox(width: 10),
                              const Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        ),
                        child: const Text('Já tenho uma conta'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.number,
    required this.title,
    required this.text,
    required this.icon,
  });

  final String number;
  final String title;
  final String text;
  final IconData icon;
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.data,
    required this.active,
  });

  final _OnboardingData data;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: active ? 1 : .55,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const BrandImage(fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, .42, .68, 1],
                    colors: [
                      Colors.black.withValues(alpha: .10),
                      Colors.black.withValues(alpha: .18),
                      AppColors.black.withValues(alpha: .70),
                      AppColors.black.withValues(alpha: .98),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 22,
                left: 22,
                child: Text(
                  data.number,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Positioned(
                top: 23,
                right: 22,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 28,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MONEY GROWTH ENGINE',
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: .70),
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.4,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 42,
                        height: .90,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -2.2,
                      ),
                    ),
                    const SizedBox(height: 13),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Text(
                        data.text,
                        style: const TextStyle(
                          color: Color(0xFFE8E4E5),
                          fontSize: 15,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
