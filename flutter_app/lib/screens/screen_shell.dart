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
      appBar: AppBar(
        leadingWidth: 64,
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: BrandMark(size: 42, borderRadius: 12),
        ),
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Opportunity Radar',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.radar),
            icon: const Icon(Icons.radar_rounded, color: AppColors.coldBlue),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: child,
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class AgentActionButton extends StatelessWidget {
  const AgentActionButton({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_forward_rounded, size: 17),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.laguna,
        foregroundColor: AppColors.darkKnight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
