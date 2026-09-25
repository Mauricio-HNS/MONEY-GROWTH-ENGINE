import 'package:flutter/material.dart';

import '../core/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class MoneyRescueScreen extends StatefulWidget {
  const MoneyRescueScreen({super.key});

  @override
  State<MoneyRescueScreen> createState() => _MoneyRescueScreenState();
}

class _MoneyRescueScreenState extends State<MoneyRescueScreen> {
  bool scanning = false;
  bool scanned = false;

  Future<void> scan() async {
    setState(() {
      scanning = true;
      scanned = false;
    });
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      scanning = false;
      scanned = true;
    });
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: FinancialStore.instance,
        builder: (_, __) {
          final store = FinancialStore.instance;
          final recurring = store.recurringExpenses;
          final potential = recurring * 0.35 + (store.totalExpenses > 1500 ? 120 : 60);
          return ScreenShell(
            title: 'Money Rescue',
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SectionCard(title: 'Find money you are losing', child: Text('Scan your current financial data for recurring costs, potential savings and legitimate opportunities. No action is executed without your authorization.', style: TextStyle(color: AppColors.textMuted, height: 1.5))),
              const SizedBox(height: 14),
              SectionCard(title: 'AI scan', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(scanned ? 'Estimated opportunity: ${money(potential)} / month' : 'Ready to scan your financial profile.', style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(scanned ? 'Recurring expenses detected: ${money(recurring)} / month. Review each recommendation before taking action.' : 'The MVP uses local financial data. API and bank integrations come later.', style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.5)),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: scanning ? null : scan, icon: scanning ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.radar_rounded), label: Text(scanning ? 'Scanning...' : 'Run financial scan'))),
              ])),
              if (scanned) ...[
                const SizedBox(height: 14),
                SectionCard(title: 'Detected opportunities', child: Column(children: [
                  _Opportunity(title: 'Recurring-cost review', amount: recurring * 0.25, icon: Icons.autorenew),
                  _Opportunity(title: 'Expense optimization', amount: recurring * 0.10, icon: Icons.trending_down),
                  const SizedBox(height: 6),
                  const Text('These are estimates for the MVP, not financial advice or guaranteed savings.', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                ])),
              ],
            ]),
          );
        },
      );
}

class _Opportunity extends StatelessWidget {
  const _Opportunity({required this.title, required this.amount, required this.icon});
  final String title;
  final double amount;
  final IconData icon;

  @override
  Widget build(BuildContext context) => ListTile(contentPadding: EdgeInsets.zero, leading: Icon(icon, color: AppColors.coldBlue), title: Text(title), trailing: Text('+ ${money(amount)}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.coldBlue)));
}
