import 'package:flutter/material.dart';
import 'screen_shell.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});
  @override Widget build(BuildContext context) => const ScreenShell(title: 'Expenses', child: _Page(title: 'Spend smarter', text: 'Identify subscriptions, tariffs, recurring costs and unnecessary expenses that can be reduced.'));
}
class _Page extends StatelessWidget { const _Page({required this.title,required this.text}); final String title,text; @override Widget build(BuildContext context)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[SectionCard(title:title,child:Text(text)),const SizedBox(height:14),SectionCard(title:'Potential savings',child:const Text('Savings opportunities will appear here.',style:TextStyle(color:Color(0xFFA8B0C3))))]); }
