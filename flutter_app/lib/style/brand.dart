import 'package:flutter/material.dart';

/// Official Money Growth Engine visual identity.
///
/// The source image currently lives in the repository README as a GitHub
/// attachment. Keeping the URL centralized makes it easy to replace it with
/// a bundled asset later without touching screens.
abstract final class BrandAssets {
  static const imageUrl =
      'https://github.com/user-attachments/assets/24b8eadf-866c-463f-b6e1-f6b38203f8c6';
  static const appName = 'MONEY GROWTH ENGINE';
}

class BrandImage extends StatelessWidget {
  const BrandImage({
    super.key,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.opacity = 1,
  });

  final BoxFit fit;
  final double borderRadius;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    Widget image = Image.network(
      BrandAssets.imageUrl,
      fit: fit,
      errorBuilder: (_, __, ___) => const ColoredBox(
        color: Color(0xFFE50914),
        child: Center(
          child: Icon(Icons.trending_up_rounded, color: Colors.white, size: 56),
        ),
      ),
    );

    if (opacity < 1) image = Opacity(opacity: opacity, child: image);
    if (borderRadius > 0) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    }
    return image;
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    this.size = 52,
    this.borderRadius = 16,
  });

  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFF171717),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.white.withValues(alpha: .18),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: const BrandImage(fit: BoxFit.cover),
      );
}
