import 'package:flutter/material.dart';

import '../routes.dart';
import '../style/brand.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _intro;
  int _page = 0;

  static const _slides = <_SplashData>[
    _SplashData(
      image:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=1400&q=90',
      kicker: '01 / CONTROL',
      headline: 'KNOW\nYOUR\nMONEY.',
      body: 'See what comes in, what goes out, and what is quietly holding you back.',
      background: Color(0xFFE50914),
      accent: Color(0xFFFFB4B8),
    ),
    _SplashData(
      image:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=1400&q=90',
      kicker: '02 / CLARITY',
      headline: 'MAKE\nNUMBERS\nMEANINGFUL.',
      body: 'Turn scattered financial data into a clear picture of your next move.',
      background: Color(0xFF171717),
      accent: Color(0xFFE50914),
    ),
    _SplashData(
      image:
          'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=1400&q=90',
      kicker: '03 / GROWTH',
      headline: 'BUILD\nWHAT\nCOMES NEXT.',
      body: 'Plan smarter. Protect your money. Grow with a system built around you.',
      background: Color(0xFFF2E8E5),
      accent: Color(0xFFE50914),
      darkText: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _intro.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeOutCubic,
      );
    } else {
      _finish();
    }
  }

  void _finish() {
    Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _slides.length,
        onPageChanged: (value) {
          setState(() => _page = value);
          _intro
            ..reset()
            ..forward();
        },
        itemBuilder: (context, index) {
          return _EditorialSlide(
            data: _slides[index],
            page: index,
            total: _slides.length,
            animation: _intro,
            onNext: _next,
            onSkip: _finish,
          );
        },
      ),
    );
  }
}

class _SplashData {
  const _SplashData({
    required this.image,
    required this.kicker,
    required this.headline,
    required this.body,
    required this.background,
    required this.accent,
    this.darkText = false,
  });

  final String image;
  final String kicker;
  final String headline;
  final String body;
  final Color background;
  final Color accent;
  final bool darkText;
}

class _EditorialSlide extends StatelessWidget {
  const _EditorialSlide({
    required this.data,
    required this.page,
    required this.total,
    required this.animation,
    required this.onNext,
    required this.onSkip,
  });

  final _SplashData data;
  final int page;
  final int total;
  final Animation<double> animation;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final foreground = data.darkText ? const Color(0xFF171717) : Colors.white;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final imageOffset = 36 * (1 - animation.value);
        final textOffset = 24 * (1 - animation.value);

        return Container(
          color: data.background,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: -imageOffset,
                right: -size.width * .18,
                width: size.width * 1.08,
                height: size.height * .70,
                child: HeroPhoto(
                  url: data.image,
                  background: data.background,
                ),
              ),

              // Strong editorial crop/gradient so the typography remains
              // readable while the photograph stays dominant.
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, .34, .60, 1],
                        colors: [
                          Colors.black.withValues(alpha: .10),
                          Colors.transparent,
                          data.background.withValues(alpha: .18),
                          data.background,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Graphic red accent bar.
              Positioned(
                top: 0,
                left: 0,
                width: 8,
                height: size.height,
                child: ColoredBox(color: data.accent),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 18, 24, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 48,
                            height: 48,
                            child: BrandImage(
                              fit: BoxFit.contain,
                              opacity: .96,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              BrandAssets.appName,
                              style: TextStyle(
                                color: foreground,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.1,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: onSkip,
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  foreground.withValues(alpha: .78),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                            child: Text(
                              page == total - 1 ? 'START' : 'SKIP',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Transform.translate(
                        offset: Offset(0, textOffset),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.kicker,
                              style: TextStyle(
                                color: data.accent,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.6,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              data.headline,
                              style: TextStyle(
                                color: foreground,
                                fontSize: 49,
                                height: .88,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -2.8,
                              ),
                            ),
                            const SizedBox(height: 18),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 330),
                              child: Text(
                                data.body,
                                style: TextStyle(
                                  color: foreground.withValues(alpha: .76),
                                  fontSize: 14,
                                  height: 1.48,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        children: [
                          _Progress(
                            current: page,
                            total: total,
                            foreground: foreground,
                            accent: data.accent,
                          ),
                          const Spacer(),
                          _NextButton(
                            label: page == total - 1 ? 'GET STARTED' : 'NEXT',
                            foreground: foreground,
                            background: data.accent,
                            onPressed: onNext,
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

class HeroPhoto extends StatelessWidget {
  const HeroPhoto({
    required this.url,
    required this.background,
  });

  final String url;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return ColoredBox(color: background);
      },
      errorBuilder: (_, __, ___) => ColoredBox(
        color: background,
        child: Icon(
          Icons.person_rounded,
          size: 110,
          color: Colors.white.withValues(alpha: .12),
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({
    required this.current,
    required this.total,
    required this.foreground,
    required this.accent,
  });

  final int current;
  final int total;
  final Color foreground;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        total,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          margin: const EdgeInsets.only(right: 6),
          width: index == current ? 30 : 7,
          height: 6,
          decoration: BoxDecoration(
            color: index == current
                ? accent
                : foreground.withValues(alpha: .28),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.label,
    required this.foreground,
    required this.background,
    required this.onPressed,
  });

  final String label;
  final Color foreground;
  final Color background;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground == Colors.white
            ? const Color(0xFF171717)
            : Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_rounded, size: 16),
        ],
      ),
    );
  }
}
