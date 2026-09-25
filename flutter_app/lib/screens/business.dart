import 'package:flutter/material.dart';
import 'screen_shell.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});
  @override Widget build(BuildContext context) => const ScreenShell(title:'Business',child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[SectionCard(title:'Business Growth',child:Text('Find products, services, clients and business models that can create additional revenue.',style:TextStyle(color:Color(0xFFA8B0C3)))),SizedBox(height:14),SectionCard(title:'Opportunities',child:Text('Business opportunities will appear here.',style:TextStyle(color:Color(0xFFA8B0C3))))]));
}
