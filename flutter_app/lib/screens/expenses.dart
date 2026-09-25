import 'package:flutter/material.dart';

import '../core/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final title = TextEditingController();
  final amount = TextEditingController();
  String category = 'Variable';

  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }

  void addExpense() {
    final value = double.tryParse(amount.text.replaceAll(',', '.'));
    if (title.text.trim().isEmpty || value == null || value <= 0) return;
    FinancialStore.instance.addExpense(title.text.trim(), value, category);
    title.clear();
    amount.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Expense added.')));
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: FinancialStore.instance,
        builder: (_, __) {
          final store = FinancialStore.instance;
          final cashFlow = store.cashFlow;
          return ScreenShell(
            title: 'Expenses',
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SectionCard(title: 'Spend smarter', child: Text('Monthly expenses: ${money(store.totalExpenses)}. The engine highlights recurring costs and areas where savings may exist.', style: const TextStyle(color: AppColors.textMuted, height: 1.5))),
              const SizedBox(height: 14),
              SectionCard(title: 'Add expense', child: Column(children: [
                TextField(controller: title, decoration: const InputDecoration(labelText: 'Expense', prefixIcon: Icon(Icons.receipt_long_outlined))),
                const SizedBox(height: 12),
                TextField(controller: amount, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Monthly amount', prefixIcon: Icon(Icons.euro_rounded))),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(value: category, decoration: const InputDecoration(labelText: 'Type'), items: const [DropdownMenuItem(value: 'Fixed', child: Text('Fixed')), DropdownMenuItem(value: 'Recurring', child: Text('Recurring')), DropdownMenuItem(value: 'Variable', child: Text('Variable'))], onChanged: (value) => setState(() => category = value!)),
                const SizedBox(height: 14),
                SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: addExpense, icon: const Icon(Icons.add), label: const Text('Add expense'))),
              ])),
              const SizedBox(height: 14),
              SectionCard(title: 'Expense breakdown', child: Column(children: [
                ...store.expenses.map((item) => ListTile(contentPadding: EdgeInsets.zero, leading: Icon(item.category == 'Recurring' ? Icons.autorenew : Icons.payments_outlined, color: AppColors.laguna), title: Text(item.title), subtitle: Text(item.category), trailing: Text(money(item.amount), style: const TextStyle(fontWeight: FontWeight.w800))),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Monthly cash flow'), Text(money(cashFlow), style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.coldBlue))]),
              ])),
            ]),
          );
        },
      );
}
