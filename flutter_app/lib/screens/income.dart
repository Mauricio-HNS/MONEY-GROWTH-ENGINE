import 'package:flutter/material.dart';

import '../core/financial_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final title = TextEditingController();
  final amount = TextEditingController();
  String category = 'Freelance';

  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }

  void addIncome() {
    final value = double.tryParse(amount.text.replaceAll(',', '.'));
    if (title.text.trim().isEmpty || value == null || value <= 0) return;

    FinancialStore.instance.addIncome(title.text.trim(), value, category);
    title.clear();
    amount.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Income source added.')));
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: FinancialStore.instance,
        builder: (_, __) {
          final store = FinancialStore.instance;

          return ScreenShell(
            title: 'Income',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionCard(
                  title: 'Find new income',
                  child: const Text(
                    'Track current income and add new revenue sources you want the engine to monitor.',
                    style: TextStyle(color: AppColors.textMuted, height: 1.5),
                  ),
                ),
                const SizedBox(height: 14),
                SectionCard(
                  title: 'Add income source',
                  child: Column(
                    children: [
                      TextField(
                        controller: title,
                        decoration: const InputDecoration(
                          labelText: 'Source',
                          prefixIcon: Icon(Icons.work_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: amount,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Monthly amount',
                          prefixIcon: Icon(Icons.euro_rounded),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: category,
                        decoration: const InputDecoration(labelText: 'Category'),
                        items: const [
                          DropdownMenuItem(value: 'Salary', child: Text('Salary')),
                          DropdownMenuItem(value: 'Freelance', child: Text('Freelance')),
                          DropdownMenuItem(value: 'Business', child: Text('Business')),
                          DropdownMenuItem(value: 'Investment', child: Text('Investment')),
                          DropdownMenuItem(value: 'Other', child: Text('Other')),
                        ],
                        onChanged: (value) => setState(() => category = value!),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: addIncome,
                          icon: const Icon(Icons.add),
                          label: const Text('Add source'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SectionCard(
                  title: 'Current income',
                  child: Column(
                    children: [
                      ...store.incomes.map(
                        (item) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.trending_up_rounded,
                            color: AppColors.coldBlue,
                          ),
                          title: Text(item.title),
                          subtitle: Text(item.category),
                          trailing: Text(
                            money(item.amount),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total monthly income'),
                          Text(
                            money(store.totalIncome),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppColors.coldBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}
