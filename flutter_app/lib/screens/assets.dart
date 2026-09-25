import 'package:flutter/material.dart';
import 'screen_shell.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});
  @override Widget build(BuildContext context) => const ScreenShell(title:'Assets',child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[SectionCard(title:'Asset Monetizer',child:Text('Find idle items, equipment, rooms and other assets that could generate cash.',style:TextStyle(color:Color(0xFFA8B0C3)))),SizedBox(height:14),SectionCard(title:'Idle assets',child:Text('Monetization opportunities will appear here.',style:TextStyle(color:Color(0xFFA8B0C3))))]));
}
