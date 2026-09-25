import 'package:flutter/material.dart';
import '../services/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});
  @override State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final name = TextEditingController();
  final value = TextEditingController();
  final allocation = TextEditingController();
  final store = FinancialStore.instance;

  @override void dispose() { name.dispose(); value.dispose(); allocation.dispose(); super.dispose(); }

  void add() {
    final v = double.tryParse(value.text.replaceAll(',', '.'));
    final a = double.tryParse(allocation.text.replaceAll(',', '.'));
    if (name.text.trim().isEmpty || v == null || v <= 0 || a == null || a < 0) return;
    store.addPosition(PortfolioPosition(name:name.text.trim(), value:v, allocation:a));
    name.clear(); value.clear(); allocation.clear(); setState(() {});
  }

  @override Widget build(BuildContext context) => ScreenShell(title:'Portfolio', child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    SectionCard(title:'Portfolio Guardian',child:Text('Monitor allocation and concentration before making investment decisions.',style:TextStyle(color:AppColors.textMuted))),
    const SizedBox(height:14),
    SectionCard(title:'Add position',child:Column(children:[
      TextField(controller:name,decoration:const InputDecoration(labelText:'Asset / position')),
      const SizedBox(height:10),
      TextField(controller:value,keyboardType:const TextInputType.numberWithOptions(decimal:true),decoration:const InputDecoration(labelText:'Current value')),
      const SizedBox(height:10),
      TextField(controller:allocation,keyboardType:const TextInputType.numberWithOptions(decimal:true),decoration:const InputDecoration(labelText:'Allocation %')),
      const SizedBox(height:12),SizedBox(width:double.infinity,child:FilledButton(onPressed:add,child:const Text('Add position'))),
    ])),
    const SizedBox(height:14),
    SectionCard(title:'Portfolio value',child:Text('€ ${store.portfolioValue.toStringAsFixed(2)}',style:const TextStyle(color:AppColors.white,fontSize:25,fontWeight:FontWeight.w800))),
    const SizedBox(height:14),
    ...store.positions.map((p)=>Card(color:AppColors.surface,child:ListTile(title:Text(p.name,style:const TextStyle(color:AppColors.white,fontWeight:FontWeight.w700)),subtitle:Text('${p.allocation.toStringAsFixed(1)}% allocation',style:const TextStyle(color:AppColors.textMuted)),trailing:Text('€ ${p.value.toStringAsFixed(2)}',style:const TextStyle(color:AppColors.coldBlue,fontWeight:FontWeight.w700)))))
  ]));
}
