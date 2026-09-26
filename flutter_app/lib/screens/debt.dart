import 'package:flutter/material.dart';

import '../core/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class DebtScreen extends StatefulWidget {
  const DebtScreen({super.key});

  @override
  State<DebtScreen> createState() => _DebtScreenState();
}

class _DebtScreenState extends State<DebtScreen> {
  final title = TextEditingController();
  final balance = TextEditingController();
  final payment = TextEditingController();
  final rate = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    balance.dispose();
    payment.dispose();
    rate.dispose();
    super.dispose();
  }

  void addDebt() {
    final debtBalance = double.tryParse(balance.text.replaceAll(',', '.'));
    final monthlyPayment = double.tryParse(payment.text.replaceAll(',', '.'));
    final interest = double.tryParse(rate.text.replaceAll(',', '.'));
    if (title.text.trim().isEmpty || debtBalance == null || monthlyPayment == null || interest == null) return;

    FinancialStore.instance.addDebt(title.text.trim(), debtBalance, monthlyPayment, interest);
    title.clear();
    balance.clear();
    payment.clear();
    rate.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Debt added.')));
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: FinancialStore.instance,
        builder: (_, __) {
          final store = FinancialStore.instance;
          final monthlyDebtPayment =
              store.debts.fold<double>(0, (sum, item) => sum + item.monthlyPayment);

          return ScreenShell(
            title: 'Debt',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionCard(
                  title: 'Debt Strategy',
                  child: Text(
                    'Total debt: ${money(store.totalDebt)}. Prioritize high-interest balances and protect monthly cash flow.',
                    style: const TextStyle(color: AppColors.textMuted, height: 1.5),
                  ),
                ),
                const SizedBox(height: 14),
                SectionCard(
                  title: 'Add debt',
                  child: Column(
                    children: [
                      TextField(
                        controller: title,
                        decoration: const InputDecoration(
                          labelText: 'Debt name',
                          prefixIcon: AppIconBadge(icon: Icons.credit_card_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: balance,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(labelText: 'Balance'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: payment,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(labelText: 'Monthly payment'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: rate,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(labelText: 'Interest rate %'),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: addDebt,
                          icon: const Icon(Icons.add),
                          label: const Text('Add debt'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SectionCard(
                  title: 'Next actions',
                  child: Column(
                    children: [
                      ...store.debts.map(
                        (item) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: AppIconBadge(icon: 
                            Icons.account_balance_wallet_outlined,
                            color: AppColors.coldBlue,
                          ),
                          title: Text(item.title),
                          subtitle: Text(
                            '${item.interestRate.toStringAsFixed(1)}% interest · ${money(item.monthlyPayment)}/mo',
                          ),
                          trailing: Text(
                            money(item.balance),
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Monthly debt payments'),
                          Text(
                            money(monthlyDebtPayment),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppColors.coldBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}
