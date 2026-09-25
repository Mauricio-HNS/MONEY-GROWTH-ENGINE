import 'package:flutter/material.dart';
import 'screen_shell.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});
  @override Widget build(BuildContext context) => const ScreenShell(title:'Portfolio',child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[SectionCard(title:'Portfolio Guardian',child:Text('Monitor allocation, concentration, volatility, costs and portfolio risk.',style:TextStyle(color:Color(0xFFA8B0C3)))),SizedBox(height:14),SectionCard(title:'Portfolio health',child:Text('Risk and allocation analysis will appear here.',style:TextStyle(color:Color(0xFFA8B0C3))))]));
}
