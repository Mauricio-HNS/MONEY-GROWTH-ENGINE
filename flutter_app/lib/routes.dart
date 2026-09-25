import 'package:flutter/material.dart';

import 'screens/assets.dart';
import 'screens/business.dart';
import 'screens/debt.dart';
import 'screens/expenses.dart';
import 'screens/home.dart';
import 'screens/income.dart';
import 'screens/investments.dart';
import 'screens/money_rescue.dart';
import 'screens/portfolio.dart';
import 'screens/radar.dart';
import 'screens/tax.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const moneyRescue = '/money-rescue';
  static const income = '/income';
  static const expenses = '/expenses';
  static const debt = '/debt';
  static const investments = '/investments';
  static const portfolio = '/portfolio';
  static const business = '/business';
  static const assets = '/assets';
  static const tax = '/tax';
  static const radar = '/radar';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Widget page = switch (settings.name) {
      home => const HomeScreen(),
      moneyRescue => const MoneyRescueScreen(),
      income => const IncomeScreen(),
      expenses => const ExpensesScreen(),
      debt => const DebtScreen(),
      investments => const InvestmentsScreen(),
      portfolio => const PortfolioScreen(),
      business => const BusinessScreen(),
      assets => const AssetsScreen(),
      tax => const TaxScreen(),
      radar => const RadarScreen(),
      _ => const HomeScreen(),
    };

    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
