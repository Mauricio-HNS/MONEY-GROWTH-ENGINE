import 'package:flutter/material.dart';
import '../services/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class RadarScreen extends StatefulWidget {
  const RadarScreen({super.key});
  @override
  State<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen> {
  final store = FinancialStore.instance;
  bool scanning = false;
  List<String> signals = [];

  Future<void> scan() async {
    setState(() {
      scanning = true;
      signals = [];
    });
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final result = <String>[];
    if (store.businessPotential > 0) {
      result.add('Business opportunities: € ${store.businessPotential.toStringAsFixed(0)}/month potential');
    }
    if (store.assetPotential > 0) {
      result.add('Asset monetization: € ${store.assetPotential.toStringAsFixed(0)}/month potential');
    }
    if (store.taxPotential > 0) {
      result.add('Tax opportunities: € ${store.taxPotential.toStringAsFixed(0)} estimated value');
    }
    if (store.totalInvestments > 0) {
      result.add('Investments tracked: € ${store.totalInvestments.toStringAsFixed(0)}');
    }
    if (result.isEmpty) {
      result.add('Complete your financial data to generate personalized opportunities.');
    }
    if (mounted) {
      setState(() {
        scanning = false;
        signals = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenShell(
      title: 'Opportunity Radar',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.laguna),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIconBadge(icon: Icons.radar_rounded, size: 38),
                const SizedBox(height: 12),
                const Text(
                  'Scan your financial life',
                  style: TextStyle(color: AppColors.white, fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Combine income, expenses, debt, investments, business, assets and tax signals into actionable opportunities.',
                  style: TextStyle(color: AppColors.textMuted, height: 1.45),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: scanning ? null : scan,
                    icon: scanning
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.radar),
                    label: Text(scanning ? 'Scanning...' : 'Run financial scan'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (signals.isNotEmpty)
            SectionCard(
              title: 'Radar signals',
              child: Column(
                children: signals
                    .map(
                      (signal) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: AppIconBadge(icon: 
                          Icons.insights_outlined,
                          color: AppColors.coldBlue,
                        ),
                        title: Text(
                          signal,
                          style: const TextStyle(color: AppColors.white),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          else
            const SectionCard(
              title: 'Next opportunities',
              child: Text(
                'Run the scan after entering your financial data.',
                style: TextStyle(color: AppColors.textMuted),
              ),
            ),
        ],
      ),
    );
  }
}