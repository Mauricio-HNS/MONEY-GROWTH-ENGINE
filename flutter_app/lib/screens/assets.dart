import 'package:flutter/material.dart';
import '../services/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});
  @override State<AssetsScreen> createState() => _AssetsScreenState();
}
class _AssetsScreenState extends State<AssetsScreen> {
  final name = TextEditingController();
  final monthly = TextEditingController();
  final store = FinancialStore.instance;
  @override void dispose() { name.dispose(); monthly.dispose(); super.dispose(); }
  void add() {
    final value = double.tryParse(monthly.text.replaceAll(',', '.'));
    if (name.text.trim().isEmpty || value == null || value <= 0) return;
    store.addAsset(AssetOpportunity(name: name.text.trim(), monthlyPotential: value));
    name.clear(); monthly.clear(); setState(() {});
  }
  @override Widget build(BuildContext context) => ScreenShell(title: 'Assets', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SectionCard(title: 'Asset Monetizer', child: Text('Identify idle equipment, rooms, vehicles and other assets that can generate cash.', style: TextStyle(color: AppColors.textMuted))),
    const SizedBox(height: 14),
    SectionCard(title: 'Add asset', child: Column(children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Asset name', prefixIcon: AppIconBadge(icon: Icons.inventory_2_outlined))),
      const SizedBox(height: 10),
      TextField(controller: monthly, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Estimated monthly revenue', prefixText: '€ ')),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, child: FilledButton(onPressed: add, child: const Text('Add asset'))),
    ])),
    const SizedBox(height: 14),
    SectionCard(title: 'Monetization potential', child: Text('€ \${store.assetPotential.toStringAsFixed(2)}/mo', style: const TextStyle(color: AppColors.white, fontSize: 25, fontWeight: FontWeight.w800))),
    const SizedBox(height: 14),
    ...store.assets.map((item) => Card(color: AppColors.surface, child: ListTile(title: Text(item.name, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700)), trailing: Text('€ \${item.monthlyPotential.toStringAsFixed(2)}/mo', style: const TextStyle(color: AppColors.coldBlue, fontWeight: FontWeight.w700)))))
  ]));
}