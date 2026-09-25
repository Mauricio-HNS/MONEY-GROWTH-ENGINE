import 'package:flutter/material.dart';
import '../services/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});
  @override State<BusinessScreen> createState() => _BusinessScreenState();
}
class _BusinessScreenState extends State<BusinessScreen> {
  final name = TextEditingController();
  final monthly = TextEditingController();
  final store = FinancialStore.instance;
  @override void dispose() { name.dispose(); monthly.dispose(); super.dispose(); }
  void add() {
    final value = double.tryParse(monthly.text.replaceAll(',', '.'));
    if (name.text.trim().isEmpty || value == null || value <= 0) return;
    store.addBusiness(BusinessOpportunity(name: name.text.trim(), monthlyPotential: value));
    name.clear(); monthly.clear(); setState(() {});
  }
  @override Widget build(BuildContext context) => ScreenShell(title: 'Business', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SectionCard(title: 'Business Growth', child: Text('Track business ideas, services, clients and revenue opportunities.', style: TextStyle(color: AppColors.textMuted))),
    const SizedBox(height: 14),
    SectionCard(title: 'Add opportunity', child: Column(children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Opportunity name', prefixIcon: Icon(Icons.business_center_outlined))),
      const SizedBox(height: 10),
      TextField(controller: monthly, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Expected monthly revenue', prefixText: '€ ')),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, child: FilledButton(onPressed: add, child: const Text('Add opportunity'))),
    ])),
    const SizedBox(height: 14),
    SectionCard(title: 'Monthly potential', child: Text('€ \${store.businessPotential.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.white, fontSize: 25, fontWeight: FontWeight.w800))),
    const SizedBox(height: 14),
    ...store.businessOpportunities.map((item) => Card(color: AppColors.surface, child: ListTile(title: Text(item.name, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700)), trailing: Text('€ \${item.monthlyPotential.toStringAsFixed(2)}/mo', style: const TextStyle(color: AppColors.coldBlue, fontWeight: FontWeight.w700)))))
  ]));
}