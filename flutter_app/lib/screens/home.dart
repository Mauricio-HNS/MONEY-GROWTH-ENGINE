import 'package:flutter/material.dart';

import '../core/financial_store.dart';
import '../routes.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: FinancialStore.instance,
      builder: (_, __) {
        final store = FinancialStore.instance;
        final income = store.setupCompleted ? store.monthlyIncome : store.totalIncome;
        final expenses = store.setupCompleted ? store.monthlyExpenses : store.totalExpenses;
        final debt = store.setupCompleted ? store.debtBalance : store.totalDebt;
        final cashFlow = store.setupCompleted ? store.setupCashFlow : store.cashFlow;
        final potential = store.recurringExpenses * 0.35 + 250;

        return ScreenShell(
          title: 'Money Growth',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.laguna, AppColors.coldBlue]),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('MONEY GROWTH ENGINE', style: TextStyle(color: AppColors.darkKnight, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.4)),
                  const SizedBox(height: 10),
                  Text(store.setupCompleted ? 'Your command center is ready.' : 'What can we improve?', style: const TextStyle(color: AppColors.darkKnight, fontSize: 27, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text(
                    store.setupCompleted
                        ? 'Your first baseline is connected. The engine can now identify opportunities around your real numbers.'
                        : 'Your AI workforce searches for ways to save, earn, recover and grow your money.',
                    style: const TextStyle(color: AppColors.darkKnight, fontSize: 13, height: 1.4),
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: _Metric(label: 'CASH FLOW', value: money(cashFlow, store.currency))),
                const SizedBox(width: 10),
                Expanded(child: _Metric(label: 'TO FIND', value: money(potential, store.currency))),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: _Metric(label: 'INCOME', value: money(income, store.currency))),
                const SizedBox(width: 10),
                Expanded(child: _Metric(label: 'EXPENSES', value: money(expenses, store.currency))),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: _Metric(label: 'DEBT', value: money(debt, store.currency))),
                const SizedBox(width: 10),
                Expanded(child: _Metric(label: 'NET WORTH', value: money(store.netWorth, store.currency))),
              ]),
              if (store.setupCompleted) ...[
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Primary mission',
                  child: Row(children: [
                    const AppIconBadge(icon: Icons.flag_rounded, size: 38, radius: 11),
                    const SizedBox(width: 12),
                    Expanded(child: Text(store.objective, style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w800))),
                  ]),
                ),
              ],
              const SizedBox(height: 22),
              const Text('YOUR MONEY TEAM', style: TextStyle(color: AppColors.white, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.4)),
              const SizedBox(height: 12),
              _AgentTile(icon: Icons.savings_outlined, title: 'Money Rescue', subtitle: 'Find money you are losing', route: AppRoutes.moneyRescue),
              _AgentTile(icon: Icons.trending_up_rounded, title: 'Income', subtitle: 'Find new ways to make money', route: AppRoutes.income),
              _AgentTile(icon: Icons.remove_circle_outline, title: 'Expenses', subtitle: 'Cut unnecessary costs', route: AppRoutes.expenses),
              _AgentTile(icon: Icons.account_balance_wallet_outlined, title: 'Debt', subtitle: 'Build a debt reduction plan', route: AppRoutes.debt),
              _AgentTile(icon: Icons.candlestick_chart_rounded, title: 'Investments', subtitle: 'Analyze assets and scenarios', route: AppRoutes.investments),
              _AgentTile(icon: Icons.pie_chart_outline_rounded, title: 'Portfolio', subtitle: 'Monitor risk and allocation', route: AppRoutes.portfolio),
              _AgentTile(icon: Icons.business_center_outlined, title: 'Business', subtitle: 'Find new revenue opportunities', route: AppRoutes.business),
              _AgentTile(icon: Icons.inventory_2_outlined, title: 'Assets', subtitle: 'Turn idle assets into cash', route: AppRoutes.assets),
              _AgentTile(icon: Icons.receipt_long_outlined, title: 'Tax', subtitle: 'Find legal tax opportunities', route: AppRoutes.tax),
              _AgentTile(icon: Icons.radar_rounded, title: 'Opportunity Radar', subtitle: 'Scan your whole financial life', route: AppRoutes.radar),
            ],
          ),
        );
      },
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 9, letterSpacing: 1)),
      const SizedBox(height: 7),
      Text(value, style: const TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}

class _AgentTile extends StatelessWidget {
  const _AgentTile({required this.icon, required this.title, required this.subtitle, required this.route});
  final IconData icon;
  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) => Card(
    color: AppColors.surface,
    margin: const EdgeInsets.only(bottom: 9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: const BorderSide(color: AppColors.border)),
    child: ListTile(
      onTap: () => Navigator.pushNamed(context, route),
      leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: AppColors.white)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.laguna),
    ),
  );
}
