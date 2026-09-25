import 'package:flutter/material.dart';
import 'screen_shell.dart';

class DebtScreen extends StatelessWidget {
  const DebtScreen({super.key});
  @override Widget build(BuildContext context) => const ScreenShell(title: 'Debt', child: _Page());
}
class _Page extends StatelessWidget { const _Page(); @override Widget build(BuildContext context)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[SectionCard(title:'Debt Strategy',child:const Text('Build a clear plan to reduce interest, prioritize debts and improve monthly cash flow.',style:TextStyle(color:Color(0xFFA8B0C3)))),const SizedBox(height:14),SectionCard(title:'Next actions',child:const Text('Debt scenarios will appear here.',style:TextStyle(color:Color(0xFFA8B0C3))))]); }
