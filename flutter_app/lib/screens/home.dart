import 'package:flutter/material.dart';
import '../core/consent_store.dart';
import '../core/financial_store.dart';
import '../routes.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: FinancialStore.instance,
      builder: (_, __) {
        final store = FinancialStore.instance;
        final consent = ConsentStore.instance;
        final income = store.setupCompleted ? store.monthlyIncome : store.totalIncome;
        final expenses = store.setupCompleted ? store.monthlyExpenses : store.totalExpenses;
        final debt = store.setupCompleted ? store.debtBalance : store.totalDebt;
        final cashFlow = store.setupCompleted ? store.setupCashFlow : store.cashFlow;
        final potential = store.recurringExpenses * 0.35 + 250;

        return ScreenShell(title: 'Money Growth', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (!consent.canScan) ...[
            SectionCard(title: 'Scan control', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Antes de analisar seus dados, configure suas autorizações.',
                style: TextStyle(color: AppColors.white, fontSize: 21, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text(consent.scanningEnabled
                  ? 'O scan ainda precisa de Dados financeiros autorizados.'
                  : 'Nenhum scan será executado até que você permita o acesso necessário.',
                style: const TextStyle(color: AppColors.textMuted, height: 1.45)),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: FilledButton.icon(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.consent),
                icon: const Icon(Icons.verified_user_outlined),
                label: const Text('CONFIGURAR AUTORIZAÇÕES'),
              )),
            ])),
            const SizedBox(height: 14),
          ] else ...[
            SectionCard(title: 'Engine ready', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Seu Engine está autorizado para iniciar análises.',
                style: TextStyle(color: AppColors.white, fontSize: 21, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const Text('As fontes autorizadas serão usadas conforme suas permissões. Você pode desligar tudo na Central de Controle.',
                style: TextStyle(color: AppColors.textMuted, height: 1.45)),
              const SizedBox(height: 14),
              SizedBox(width: double.infinity, child: FilledButton.icon(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.radar),
                icon: const Icon(Icons.radar_rounded),
                label: const Text('INICIAR SCAN'),
              )),
            ])),
            const SizedBox(height: 14),
          ],
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
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.privacy),
            icon: const Icon(Icons.shield_outlined),
            label: const Text('CENTRAL DE CONTROLE E PRIVACIDADE'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              foregroundColor: AppColors.white,
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
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
        ]));
      },
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label; final String value;
  @override Widget build(BuildContext context) => Container(
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
  final IconData icon; final String title; final String subtitle; final String route;
  @override Widget build(BuildContext context) => Card(
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
