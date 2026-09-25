import 'package:flutter/material.dart';
import 'screen_shell.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});
  @override Widget build(BuildContext context) => const ScreenShell(title:'Investments',child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[SectionCard(title:'Investment Intelligence',child:Text('Analyze stocks, ETFs, funds, bonds and other assets using risk, return and scenario analysis.',style:TextStyle(color:Color(0xFFA8B0C3)))),SizedBox(height:14),SectionCard(title:'Watchlist',child:Text('Investment ideas and simulations will appear here.',style:TextStyle(color:Color(0xFFA8B0C3))))]));
}
