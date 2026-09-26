import 'package:flutter/material.dart';
import '../routes.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class FinancialSetupScreen extends StatefulWidget {
  const FinancialSetupScreen({super.key});
  @override State<FinancialSetupScreen> createState() => _FinancialSetupScreenState();
}
class _FinancialSetupScreenState extends State<FinancialSetupScreen> {
  String currency = 'EUR';
  String objective = 'Recover money';
  double monthlyIncome = 0;

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'Financial setup',
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('SET YOUR BASELINE', style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2.8)),
      const SizedBox(height: 8),
      const Text('MAKE MONEY\nVISIBLE.', style: TextStyle(color: AppColors.white, fontSize: 39, fontWeight: FontWeight.w900, height: .92, letterSpacing: -2)),
      const SizedBox(height: 14),
      const Text('Give the engine enough context to build your first financial command center.', style: TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.5)),
      const SizedBox(height: 28),
      DropdownButtonFormField<String>(
        initialValue: currency,
        decoration: const InputDecoration(labelText: 'Base currency', prefixIcon: Icon(Icons.currency_exchange)),
        items: const [
          DropdownMenuItem(value: 'EUR', child: Text('EUR — Euro')),
          DropdownMenuItem(value: 'BRL', child: Text('BRL — Brazilian Real')),
          DropdownMenuItem(value: 'USD', child: Text('USD — US Dollar')),
        ],
        onChanged: (value) => setState(() => currency = value!),
      ),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        initialValue: objective,
        decoration: const InputDecoration(labelText: 'Primary objective', prefixIcon: Icon(Icons.flag_outlined)),
        items: const [
          DropdownMenuItem(value: 'Recover money', child: Text('Recover money')),
          DropdownMenuItem(value: 'Increase income', child: Text('Increase income')),
          DropdownMenuItem(value: 'Reduce debt', child: Text('Reduce debt')),
          DropdownMenuItem(value: 'Build investments', child: Text('Build investments')),
        ],
        onChanged: (value) => setState(() => objective = value!),
      ),
      const SizedBox(height: 22),
      Text('MONTHLY INCOME  ${currency == 'EUR' ? '€' : currency == 'BRL' ? 'R\$' : '\$'} ${monthlyIncome.toStringAsFixed(0)}', style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w900, letterSpacing: 1)),
      Slider(value: monthlyIncome, max: 20000, divisions: 200, label: monthlyIncome.toStringAsFixed(0), onChanged: (value) => setState(() => monthlyIncome = value)),
      const SizedBox(height: 18),
      SizedBox(width: double.infinity, child: FilledButton(onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home), child: const Text('BUILD MY DASHBOARD'))),
    ]),
  );
}
