import 'package:flutter/material.dart';
import 'screen_shell.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});
  @override
  Widget build(BuildContext context) => const ScreenShell(title: 'Income', child: _AgentPage(title: 'Find new income', description: 'Search for jobs, freelance work, clients, services and monetization opportunities.'));
}
class _AgentPage extends StatelessWidget {
  const _AgentPage({required this.title, required this.description}); final String title; final String description;
  @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SectionCard(title: title, child: Text(description)), const SizedBox(height: 14), SectionCard(title: 'Opportunities', child: const Text('Your AI income opportunities will appear here.', style: TextStyle(color: Color(0xFFA8B0C3))))]);
}
