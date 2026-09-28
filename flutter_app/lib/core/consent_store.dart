import 'package:flutter/foundation.dart';

enum ConsentKey {
  financialData, bankAccounts, cards, investments, debts, documents, email,
  externalResearch, notifications,
}

class ConsentItem {
  const ConsentItem({
    required this.key, required this.title, required this.description,
    required this.detail, this.requiredForScan = false,
  });
  final ConsentKey key;
  final String title;
  final String description;
  final String detail;
  final bool requiredForScan;
}

class ConsentStore extends ChangeNotifier {
  ConsentStore._();
  static final instance = ConsentStore._();

  bool scanningEnabled = false;
  final Map<ConsentKey, bool> _grants = {
    ConsentKey.financialData: false, ConsentKey.bankAccounts: false,
    ConsentKey.cards: false, ConsentKey.investments: false,
    ConsentKey.debts: false, ConsentKey.documents: false,
    ConsentKey.email: false, ConsentKey.externalResearch: false,
    ConsentKey.notifications: false,
  };

  static const items = <ConsentItem>[
    ConsentItem(key: ConsentKey.financialData, title: 'Dados financeiros',
      description: 'Receitas, despesas e fluxo de caixa.',
      detail: 'Permite estruturar sua situação financeira para a análise.',
      requiredForScan: true),
    ConsentItem(key: ConsentKey.bankAccounts, title: 'Contas bancárias',
      description: 'Movimentações e transações autorizadas.',
      detail: 'Usado para detectar padrões, recorrências e anomalias.'),
    ConsentItem(key: ConsentKey.cards, title: 'Cartões',
      description: 'Gastos e pagamentos autorizados.',
      detail: 'Ajuda a identificar custos recorrentes e mudanças de comportamento.'),
    ConsentItem(key: ConsentKey.investments, title: 'Investimentos',
      description: 'Carteira e posições informadas ou conectadas.',
      detail: 'Permite analisar patrimônio, concentração e cenários.'),
    ConsentItem(key: ConsentKey.debts, title: 'Dívidas',
      description: 'Saldos, parcelas e custos informados ou conectados.',
      detail: 'Permite calcular custo, evolução e cenários de redução.'),
    ConsentItem(key: ConsentKey.documents, title: 'Documentos',
      description: 'Faturas, contratos e comprovantes.',
      detail: 'O Engine poderá extrair informações financeiras dos documentos autorizados.'),
    ConsentItem(key: ConsentKey.email, title: 'E-mail',
      description: 'Mensagens financeiras selecionadas.',
      detail: 'Opcional. Permite procurar informações financeiras em mensagens autorizadas.'),
    ConsentItem(key: ConsentKey.externalResearch, title: 'Pesquisa externa',
      description: 'Mercado, preços, oportunidades e informações atuais.',
      detail: 'Permite complementar a análise com fontes externas autorizadas.'),
    ConsentItem(key: ConsentKey.notifications, title: 'Notificações',
      description: 'Alertas sobre novas descobertas.',
      detail: 'Permite receber avisos do aplicativo.'),
  ];

  bool isGranted(ConsentKey key) => _grants[key] ?? false;
  int get grantedCount => _grants.values.where((v) => v).length;
  bool get canScan => scanningEnabled && isGranted(ConsentKey.financialData);

  void setGrant(ConsentKey key, bool value) {
    _grants[key] = value;
    notifyListeners();
  }
  void setScanning(bool value) {
    scanningEnabled = value;
    notifyListeners();
  }
  void revokeAll() {
    for (final key in _grants.keys) { _grants[key] = false; }
    scanningEnabled = false;
    notifyListeners();
  }
}
