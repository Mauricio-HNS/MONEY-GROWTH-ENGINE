import 'package:flutter/material.dart';
import '../core/consent_store.dart';
import '../core/financial_store.dart';
import '../routes.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class RadarScreen extends StatefulWidget {
  const RadarScreen({super.key});
  @override State<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen> {
  final store = FinancialStore.instance;
  final consent = ConsentStore.instance;
  bool scanning = false;
  List<String> signals = [];

  Future<void> scan() async {
    if (!consent.canScan) {
      if (mounted) Navigator.pushNamed(context, AppRoutes.consent);
      return;
    }
    setState(() { scanning = true; signals = []; });
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    final result = <String>[];
    if (store.businessPotential > 0 && consent.isGranted(ConsentKey.externalResearch)) {
      result.add('Business opportunities: € ' + store.businessPotential.toStringAsFixed(0) + '/month potential');
    }
    if (store.assetPotential > 0) result.add('Asset monetization: € ' + store.assetPotential.toStringAsFixed(0) + '/month potential');
    if (store.taxPotential > 0) result.add('Tax opportunities: € ' + store.taxPotential.toStringAsFixed(0) + ' estimated value');
    if (store.totalInvestments > 0 && consent.isGranted(ConsentKey.investments)) {
      result.add('Investments tracked: € ' + store.totalInvestments.toStringAsFixed(0));
    }
    result.add('Scan completed using ' + consent.grantedCount.toString() + ' authorized source(s).');
    setState(() { scanning = false; signals = result; });
  }

  @override Widget build(BuildContext context) => ScreenShell(
    title: 'Opportunity Radar',
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionCard(title: 'Financial scan', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppIconBadge(icon: Icons.radar_rounded, size: 38),
        const SizedBox(height: 12),
        Text(consent.canScan ? 'Ready to scan' : 'Scan blocked',
          style: const TextStyle(color: AppColors.white, fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 7),
        Text(consent.canScan
          ? 'The Engine will analyze only the sources currently authorized by you.'
          : 'No analysis can start until the required permission is enabled.',
          style: const TextStyle(color: AppColors.textMuted, height: 1.45)),
        const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: FilledButton.icon(
          onPressed: scanning ? null : scan,
          icon: scanning ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.radar),
          label: Text(scanning ? 'Scanning...' : (consent.canScan ? 'Run financial scan' : 'Configure permissions')),
        )),
        const SizedBox(height: 8),
        Align(alignment: Alignment.centerRight, child: TextButton.icon(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.privacy),
          icon: const Icon(Icons.shield_outlined, size: 16),
          label: const Text('Control access'),
        )),
      ])),
      const SizedBox(height: 14),
      if (signals.isNotEmpty)
        SectionCard(title: 'Scan results', child: Column(children: signals.map((signal) => ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const AppIconBadge(icon: Icons.insights_outlined),
          title: Text(signal, style: const TextStyle(color: AppColors.white)),
        )).toList()))
      else
        const SectionCard(title: 'Waiting for scan', child: Text(
          'The Engine will show findings here after an authorized scan.',
          style: TextStyle(color: AppColors.textMuted),
        )),
    ]),
  );
}
