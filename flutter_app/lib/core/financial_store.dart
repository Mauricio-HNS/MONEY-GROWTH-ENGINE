import 'package:flutter/foundation.dart';

class MoneyEntry {
  MoneyEntry({required this.title, required this.amount, required this.category});
  final String title;
  final double amount;
  final String category;
}

class DebtEntry {
  DebtEntry({required this.title, required this.balance, required this.monthlyPayment, required this.interestRate});
  final String title;
  final double balance;
  final double monthlyPayment;
  final double interestRate;
}

class FinancialStore extends ChangeNotifier {
  FinancialStore._();
  static final instance = FinancialStore._();

  final List<MoneyEntry> incomes = [
    MoneyEntry(title: 'Primary income', amount: 2400, category: 'Salary'),
  ];
  final List<MoneyEntry> expenses = [
    MoneyEntry(title: 'Housing', amount: 950, category: 'Fixed'),
    MoneyEntry(title: 'Subscriptions', amount: 85, category: 'Recurring'),
    MoneyEntry(title: 'Transport', amount: 180, category: 'Variable'),
  ];
  final List<DebtEntry> debts = [
    DebtEntry(title: 'Credit card', balance: 8400, monthlyPayment: 320, interestRate: 19.9),
  ];

  String currency = 'EUR';
  String objective = 'Increase income';
  double monthlyIncome = 0;
  double monthlyExpenses = 0;
  bool hasDebt = false;
  double debtBalance = 0;
  double investments = 0;
  double assets = 0;
  bool setupCompleted = false;

  double get totalIncome => incomes.fold(0, (sum, item) => sum + item.amount);
  double get totalExpenses => expenses.fold(0, (sum, item) => sum + item.amount);
  double get cashFlow => totalIncome - totalExpenses;
  double get totalDebt => debts.fold(0, (sum, item) => sum + item.balance);
  double get recurringExpenses => expenses.where((item) => item.category == 'Recurring').fold(0, (sum, item) => sum + item.amount);
  double get setupCashFlow => monthlyIncome - monthlyExpenses;
  double get netWorth => assets + investments - debtBalance;

  void completeSetup({
    required String currency,
    required String objective,
    required double monthlyIncome,
    required double monthlyExpenses,
    required bool hasDebt,
    required double debtBalance,
    required double investments,
    required double assets,
  }) {
    this.currency = currency;
    this.objective = objective;
    this.monthlyIncome = monthlyIncome;
    this.monthlyExpenses = monthlyExpenses;
    this.hasDebt = hasDebt;
    this.debtBalance = hasDebt ? debtBalance : 0;
    this.investments = investments;
    this.assets = assets;
    setupCompleted = true;
    notifyListeners();
  }

  void addIncome(String title, double amount, String category) {
    incomes.add(MoneyEntry(title: title, amount: amount, category: category));
    notifyListeners();
  }

  void addExpense(String title, double amount, String category) {
    expenses.add(MoneyEntry(title: title, amount: amount, category: category));
    notifyListeners();
  }

  void addDebt(String title, double balance, double payment, double rate) {
    debts.add(DebtEntry(title: title, balance: balance, monthlyPayment: payment, interestRate: rate));
    notifyListeners();
  }
}

String money(double value, [String currency = 'EUR']) {
  final symbol = switch (currency) {
    'BRL' => 'R\$',
    'USD' => '\$',
    _ => '€',
  };
  return symbol + ' ' + value.toStringAsFixed(0);
}
