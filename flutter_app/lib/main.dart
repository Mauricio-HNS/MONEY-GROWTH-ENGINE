import 'package:flutter/material.dart';

import 'routes.dart';
import 'style/app_style.dart';

void main() {
  runApp(const MoneyGrowthApp());
}

class MoneyGrowthApp extends StatelessWidget {
  const MoneyGrowthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Growth Engine',
      debugShowCheckedModeBanner: false,
      theme: AppStyle.theme(),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
