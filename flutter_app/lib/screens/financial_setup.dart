import 'package:flutter/material.dart';
import '../core/financial_store.dart';
import '../routes.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class FinancialSetupScreen extends StatefulWidget {
  const FinancialSetupScreen({super.key});
  @override State<FinancialSetupScreen> createState() => _FinancialSetupScreenState();
}

class _FinancialSetupScreenState extends State<FinancialSetupScreen> {
  final formKey = GlobalKey<FormState>();
  final pageController = PageController();
  String currency = 'EUR';
  String objective = 'Increase income';
  bool hasDebt = false;
  final income = TextEditingController();
  final expenses = TextEditingController();
  final debt = TextEditingController();
  final investments = TextEditingController();
  final assets = TextEditingController();
  int page = 0;

  @override
  void dispose() {
    pageController.dispose();
    income.dispose();
    expenses.dispose();
    debt.dispose();
    investments.dispose();
    assets.dispose();
    super.dispose();
  }

  double number(TextEditingController controller) => double.tryParse(controller.text.replaceAll(',', '.')) ?? 0;

  void next() {
    FocusScope.of(context).unfocus();
    if (page == 0 && !formKey.currentState!.validate()) return;
    if (page < 2) {
      setState(() => page++);
      pageController.animateToPage(page, duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic);
      return;
    }
    complete();
  }

  void back() {
    if (page == 0) {
      Navigator.pop(context);
      return;
    }
    setState(() => page--);
    pageController.animateToPage(page, duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic);
  }

  void complete() {
    if (!formKey.currentState!.validate()) {
      setState(() => page = 0);
      pageController.animateToPage(0, duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic);
      return;
    }
    FinancialStore.instance.completeSetup(
      currency: currency,
      objective: objective,
      monthlyIncome: number(income),
      monthlyExpenses: number(expenses),
      hasDebt: hasDebt,
      debtBalance: hasDebt ? number(debt) : 0,
      investments: number(investments),
      assets: number(assets),
    );
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'Financial setup',
    child: Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _progress(),
        const SizedBox(height: 22),
        SizedBox(height: 570, child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [_incomePage(), _balancePage(), _goalPage()],
        )),
        const SizedBox(height: 6),
        Row(children: [
          if (page > 0) Expanded(child: OutlinedButton.icon(onPressed: back, icon: const Icon(Icons.arrow_back_rounded), label: const Text('BACK'))) else const Spacer(),
          const SizedBox(width: 10),
          Expanded(flex: 2, child: FilledButton.icon(onPressed: next, icon: Icon(page == 2 ? Icons.check_rounded : Icons.arrow_forward_rounded), label: Text(page == 2 ? 'BUILD MY DASHBOARD' : 'CONTINUE'))),
        ]),
      ]),
    ),
  );

  Widget _progress() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('STEP ' + (page + 1).toString() + ' OF 3', style: const TextStyle(color: AppColors.red, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2.2)),
    const SizedBox(height: 8),
    Row(children: List.generate(3, (index) => Expanded(child: Container(height: 4, margin: EdgeInsets.only(right: index == 2 ? 0 : 6), decoration: BoxDecoration(color: index <= page ? AppColors.red : AppColors.border, borderRadius: BorderRadius.circular(99)))))),
  ]);

  Widget _incomePage() => _Step(
    eyebrow: 'YOUR MONTH',
    title: 'MAKE CASH FLOW\nVISIBLE.',
    description: 'Start with the two numbers that define your monthly breathing room.',
    children: [
      _moneyField('Monthly income', income, Icons.south_west_rounded, required: true),
      const SizedBox(height: 12),
      _moneyField('Monthly expenses', expenses, Icons.north_east_rounded, required: true),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        initialValue: currency,
        decoration: const InputDecoration(labelText: 'Base currency', prefixIcon: AppIconBadge(icon: Icons.currency_exchange)),
        items: const [
          DropdownMenuItem(value: 'EUR', child: Text('EUR — Euro')),
          DropdownMenuItem(value: 'BRL', child: Text('BRL — Brazilian Real')),
          DropdownMenuItem(value: 'USD', child: Text('USD — US Dollar')),
        ],
        onChanged: (value) => setState(() => currency = value!),
      ),
    ],
  );

  Widget _balancePage() => _Step(
    eyebrow: 'YOUR BALANCE SHEET',
    title: 'KNOW WHAT\nYOU OWN.',
    description: 'Debt, investments and assets give the engine a starting view of your net worth.',
    children: [
      const Text('DO YOU HAVE DEBT?', style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
      const SizedBox(height: 8),
      SegmentedButton<bool>(
        segments: const [
          ButtonSegment(value: false, label: Text('NO'), icon: Icon(Icons.check_rounded)),
          ButtonSegment(value: true, label: Text('YES'), icon: Icon(Icons.warning_amber_rounded)),
        ],
        selected: {hasDebt},
        onSelectionChanged: (value) => setState(() => hasDebt = value.first),
      ),
      if (hasDebt) ...[
        const SizedBox(height: 12),
        _moneyField('Total debt balance', debt, Icons.credit_card_rounded, required: true),
      ],
      const SizedBox(height: 12),
      _moneyField('Investments today', investments, Icons.candlestick_chart_rounded),
      const SizedBox(height: 12),
      _moneyField('Assets value', assets, Icons.home_work_outlined),
    ],
  );

  Widget _goalPage() => _Step(
    eyebrow: 'YOUR DIRECTION',
    title: 'CHOOSE THE\nMISSION.',
    description: 'The engine will use this as the first priority for your recommendations.',
    children: [
      DropdownButtonFormField<String>(
        initialValue: objective,
        decoration: const InputDecoration(labelText: 'Main financial goal', prefixIcon: AppIconBadge(icon: Icons.flag_outlined)),
        items: const [
          DropdownMenuItem(value: 'Recover money', child: Text('Recover money')),
          DropdownMenuItem(value: 'Increase income', child: Text('Increase income')),
          DropdownMenuItem(value: 'Reduce debt', child: Text('Reduce debt')),
          DropdownMenuItem(value: 'Build investments', child: Text('Build investments')),
          DropdownMenuItem(value: 'Build wealth', child: Text('Build wealth')),
        ],
        onChanged: (value) => setState(() => objective = value!),
      ),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.surfaceSoft.withValues(alpha: .72), borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
        child: Row(children: [
          const Icon(Icons.auto_awesome_rounded, color: AppColors.red),
          const SizedBox(width: 12),
          Expanded(child: Text('Your dashboard will be built around “' + objective + '”.', style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.4))),
        ]),
      ),
    ],
  );

  Widget _moneyField(String label, TextEditingController controller, IconData icon, {bool required = false}) => TextFormField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    style: const TextStyle(color: AppColors.white),
    validator: (value) {
      final amount = double.tryParse((value ?? '').replaceAll(',', '.'));
      if (required && (value == null || value.trim().isEmpty)) return 'Enter an amount';
      if (value != null && value.trim().isNotEmpty && (amount == null || amount < 0)) return 'Enter a valid amount';
      return null;
    },
    decoration: InputDecoration(labelText: label, prefixIcon: AppIconBadge(icon: icon)),
  );
}

class _Step extends StatelessWidget {
  const _Step({required this.eyebrow, required this.title, required this.description, required this.children});
  final String eyebrow;
  final String title;
  final String description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.only(right: 2, bottom: 10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(eyebrow, style: const TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2.4)),
      const SizedBox(height: 7),
      Text(title, style: const TextStyle(color: AppColors.white, fontSize: 35, fontWeight: FontWeight.w900, height: .94, letterSpacing: -1.8)),
      const SizedBox(height: 12),
      Text(description, style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.5)),
      const SizedBox(height: 22),
      ...children,
    ]),
  );
}
