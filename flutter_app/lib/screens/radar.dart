import 'package:flutter/material.dart';
import 'screen_shell.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});
  @override Widget build(BuildContext context) => ScreenShell(title:'Opportunity Radar',child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Container(width:double.infinity,padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:const Color(0xFF22263A),borderRadius:BorderRadius.circular(20),border:Border.all(color:const Color(0xFF35ACBE))),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(Icons.radar_rounded,color:Color(0xFF7DE2DF),size:38),SizedBox(height:12),Text('Scan your whole financial life',style:TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.w800)),SizedBox(height:7),Text('The radar will combine rescue, income, expenses, debt, investments, business, assets and tax signals.',style:TextStyle(color:Color(0xFFA8B0C3),height:1.45))]),),const SizedBox(height:14),const SectionCard(title:'Next opportunities',child:Text('Run the AI scan to discover and prioritize opportunities by potential value, effort and risk.',style:TextStyle(color:Color(0xFFA8B0C3))))]));
}
