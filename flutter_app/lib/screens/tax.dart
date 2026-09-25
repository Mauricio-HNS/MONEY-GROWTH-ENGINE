import 'package:flutter/material.dart';
import 'screen_shell.dart';

class TaxScreen extends StatelessWidget {
  const TaxScreen({super.key});
  @override Widget build(BuildContext context) => const ScreenShell(title:'Tax',child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[SectionCard(title:'Tax Optimizer',child:Text('Identify legal deductions, credits, refunds and tax-planning opportunities.',style:TextStyle(color:Color(0xFFA8B0C3)))),SizedBox(height:14),SectionCard(title:'Tax opportunities',child:Text('Potential tax opportunities will appear here.',style:TextStyle(color:Color(0xFFA8B0C3))))]));
}
