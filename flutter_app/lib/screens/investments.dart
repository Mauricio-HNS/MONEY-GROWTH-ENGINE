import 'package:flutter/material.dart';
import '../services/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});
  @override State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  final name = TextEditingController();
  final amount = TextEditingController();
  String type = 'ETF';
  final store = FinancialStore.instance;

  @override void dispose() { name.dispose(); amount.dispose(); super.dispose(); }

  void add() {
    final value = double.tryParse(amount.text.replaceAll(',', '.'));
    if (name.text.trim().isEmpty || value == null || value <= 0) return;
    store.addInvestment(Investment(name: name.text.trim(), amount: value, type: type));
    name.clear(); amount.clear(); setState(() {});
  }

  @override Widget build(BuildContext context) => ScreenShell(title: 'Investments', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SectionCard(title: 'Investment Intelligence', child: Text('Track invested capital and organize your assets by type.', style: TextStyle(color: AppColors.textMuted))),
    const SizedBox(height: 14),
    SectionCard(title: 'Add investment', child: Column(children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Investment name', prefixIcon: Icon(Icons.show_chart))),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(value: type, decoration: const InputDecoration(labelText: 'Type'), items: const ['ETF','Stock','Fund','Bond','Crypto','Other'].map((e) => DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged:(v)=>setState(()=>type=v!)),
      const SizedBox(height: 10),
      TextField(controller: amount, keyboardType: const TextInputType.numberWithOptions(decimal:true), decoration: const InputDecoration(labelText: 'Amount')),
      const SizedBox(height: 12), SizedBox(width:double.infinity, child:FilledButton(onPressed:add, child:const Text('Add investment'))),
    ])),
    const SizedBox(height: 14),
    SectionCard(title: 'Invested capital', child: Text('€ ${store.totalInvestments.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.white, fontSize: 25, fontWeight: FontWeight.w800))),
    const SizedBox(height: 14),
    ...store.investments.map((item) => Card(color:AppColors.surface, child:ListTile(title:Text(item.name, style:const TextStyle(color:AppColors.white,fontWeight:FontWeight.w700)), subtitle:Text(item.type, style:const TextStyle(color:AppColors.textMuted)), trailing:Text('€ ${item.amount.toStringAsFixed(2)}', style:const TextStyle(color:AppColors.coldBlue,fontWeight:FontWeight.w700)))))
  ]));
}
