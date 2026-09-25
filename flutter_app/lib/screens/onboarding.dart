import 'package:flutter/material.dart';

import '../routes.dart';
import '../style/app_style.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final _pages = const [
    _OnboardingPage(icon: Icons.search_rounded, title: 'Find hidden money', text: 'Detect wasted spending, forgotten opportunities and financial leaks.'),
    _OnboardingPage(icon: Icons.psychology_alt_rounded, title: 'Build your money team', text: 'Specialized financial agents help you recover, earn, reduce debt and grow.'),
    _OnboardingPage(icon: Icons.auto_graph_rounded, title: 'Turn insight into action', text: 'Create a clear financial plan and track the opportunities that matter.'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final last = _page == _pages.length - 1;
    return Scaffold(
      backgroundColor: AppColors.darkKnight,
      body: SafeArea(
        child: Column(
          children: [
            Align(alignment: Alignment.topRight, child: TextButton(onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login), child: const Text('Skip'))),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (value) => setState(() => _page = value),
                itemBuilder: (_, index) => _pages[index],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_pages.length, (i) => AnimatedContainer(duration: const Duration(milliseconds: 200), margin: const EdgeInsets.symmetric(horizontal: 4), width: i == _page ? 26 : 7, height: 7, decoration: BoxDecoration(color: i == _page ? AppColors.laguna : AppColors.border, borderRadius: BorderRadius.circular(10))))),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {
                    if (last) {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    } else {
                      _controller.nextPage(duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
                    }
                  },
                  child: Text(last ? 'Get started' : 'Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.icon, required this.title, required this.text});
  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 118, height: 118, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(36), border: Border.all(color: AppColors.border)), child: Icon(icon, size: 58, color: AppColors.laguna)),
            const SizedBox(height: 42),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.white, fontSize: 29, fontWeight: FontWeight.w900)),
            const SizedBox(height: 16),
            Text(text, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textMuted, fontSize: 15, height: 1.5)),
          ],
        ),
      );
}
