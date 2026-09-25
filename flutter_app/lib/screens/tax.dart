import 'package:flutter/material.dart';
import '../services/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class TaxScreen extends StatefulWidget {
  const TaxScreen({super.key});
  @override State<TaxScreen> createState() => _TaxScreenState();
}
class _TaxScreenState extends State<TaxScreen> {
  final name = TextEditingController();
  final amount = TextEditingController();
  final store = FinancialStore.instance;
  @override void dispose() { name.dispose(); amount.dispose(); super.dispose(); }
  void add() {
    final value = double.tryParse(amount.text.replaceAll(',', '.'));
    if (name.text.trim().isEmpty || value == null || value <= 0) return;
    store.addTax(TaxOpportunity(name: name.text.trim(), estimatedValue: value));
    name.clear(); amount.clear(); setState(() {});
  }
  @override Widget build(BuildContext context) => ScreenShell(title: 'Tax', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SectionCard(title: 'Tax Optimizer', child: Text('Track legal deductions, credits, refunds and planning opportunities.', style: TextStyle(color: AppColors.textMuted))),
    const SizedBox(height: 14),
    SectionCard(title: 'Add opportunity', child: Column(children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Opportunity', prefixIcon: Icon(Icons.receipt_long_outlined))),
      const SizedBox(height: 10),
      TextField(controller: amount, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Estimated value', prefixText: '€ ')),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, child: FilledButton(onPressed: add, child: const Text('Add tax opportunity'))),
    ])),
    const SizedBox(height: 14),
    SectionCard(title: 'Estimated annual value', child: Text('€ \${store.taxPotential.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.white, fontSize: 25, fontWeight: FontWeight.w800))),
    const SizedBox(height: 14),
    ...store.taxOpportunities.map((item) => Card(color: AppColors.surface, child: ListTile(title: Text(item.name, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700)), trailing: Text('€ \${item.estimatedValue.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.coldBlue, fontWeight: FontWeight.w700)))))
  ]));
}