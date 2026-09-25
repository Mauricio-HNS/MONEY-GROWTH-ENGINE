import 'package:flutter/material.dart';
import 'screen_shell.dart';

class MoneyRescueScreen extends StatelessWidget {
  const MoneyRescueScreen({super.key});
  @override
  Widget build(BuildContext context) => const ScreenShell(title: 'Money Rescue', child: _Content(title: 'Find money you are losing', text: 'Recover forgotten refunds, duplicate charges, unused benefits and other legitimate financial opportunities.'));
}

class _Content extends StatelessWidget {
  const _Content({required this.title, required this.text});
  final String title; final String text;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SectionCard(title: title, child: Text(text)), const SizedBox(height: 14), SectionCard(title: 'AI scan', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Potential opportunities will appear here.', style: TextStyle(color: Colors.white)), SizedBox(height: 8), Text('No action is executed without your authorization.', style: TextStyle(color: Color(0xFFA8B0C3), fontSize: 12))]))]);
}
