import 'package:flutter/foundation.dart';

class FinancialStore extends ChangeNotifier {
  static final FinancialStore instance = FinancialStore._();
  FinancialStore._();

  final List<Investment> investments = [];
  final List<PortfolioPosition> positions = [];
  final List<BusinessOpportunity> businessOpportunities = [];
  final List<AssetOpportunity> assets = [];
  final List<TaxOpportunity> taxOpportunities = [];

  void addInvestment(Investment item) { investments.add(item); notifyListeners(); }
  void addPosition(PortfolioPosition item) { positions.add(item); notifyListeners(); }
  void addBusiness(BusinessOpportunity item) { businessOpportunities.add(item); notifyListeners(); }
  void addAsset(AssetOpportunity item) { assets.add(item); notifyListeners(); }
  void addTax(TaxOpportunity item) { taxOpportunities.add(item); notifyListeners(); }

  double get totalInvestments => investments.fold(0, (sum, item) => sum + item.amount);
  double get portfolioValue => positions.fold(0, (sum, item) => sum + item.value);
  double get businessPotential => businessOpportunities.fold(0, (sum, item) => sum + item.monthlyPotential);
  double get assetPotential => assets.fold(0, (sum, item) => sum + item.monthlyPotential);
  double get taxPotential => taxOpportunities.fold(0, (sum, item) => sum + item.estimatedValue);
}

class Investment {
  Investment({required this.name, required this.amount, required this.type});
  final String name;
  final double amount;
  final String type;
}

class PortfolioPosition {
  PortfolioPosition({required this.name, required this.value, required this.allocation});
  final String name;
  final double value;
  final double allocation;
}

class BusinessOpportunity {
  BusinessOpportunity({required this.name, required this.monthlyPotential});
  final String name;
  final double monthlyPotential;
}

class AssetOpportunity {
  AssetOpportunity({required this.name, required this.monthlyPotential});
  final String name;
  final double monthlyPotential;
}

class TaxOpportunity {
  TaxOpportunity({required this.name, required this.estimatedValue});
  final String name;
  final double estimatedValue;
}
