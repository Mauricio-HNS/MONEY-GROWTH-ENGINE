import 'package:flutter/material.dart';
import '../core/consent_store.dart';
import '../routes.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});
  @override State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  final consent = ConsentStore.instance;
  @override void initState() { super.initState(); consent.addListener(_refresh); }
  @override void dispose() { consent.removeListener(_refresh); super.dispose(); }
  void _refresh() { if (mounted) setState(() {}); }

  void _details(ConsentItem item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => SafeArea(child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 44, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(20)))),
          const SizedBox(height: 24),
          Text(item.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          Text(item.detail, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 18),
          const Text('Você pode desligar esta permissão a qualquer momento na Central de Controle.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.45)),
        ]),
      )),
    );
  }

  @override Widget build(BuildContext context) => ScreenShell(
    title: 'Data Control', showRadar: false,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionCard(title: 'Antes do primeiro scan', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Você decide o que o Engine pode analisar.',
          style: TextStyle(color: AppColors.white, fontSize: 22, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text('Nenhum scan começa sem sua autorização. Cada fonte é independente e pode ser desligada depois.',
          style: TextStyle(color: AppColors.textMuted, height: 1.45)),
        const SizedBox(height: 18),
        Row(children: [
          _Chip(text: consent.grantedCount.toString() + '/' + ConsentStore.items.length.toString() + ' autorizadas'),
          const SizedBox(width: 8),
          _Chip(text: consent.scanningEnabled ? 'SCAN ATIVO' : 'SCAN PAUSADO'),
        ]),
      ])),
      const SizedBox(height: 14),
      _MasterSwitch(enabled: consent.scanningEnabled, onChanged: consent.grantedCount == 0 ? null : consent.setScanning),
      const SizedBox(height: 14),
      ...ConsentStore.items.map((item) => _PermissionTile(
        item: item, enabled: consent.isGranted(item.key),
        onChanged: (v) => consent.setGrant(item.key, v),
        onDetails: () => _details(item),
      )),
      const SizedBox(height: 10),
      SizedBox(width: double.infinity, height: 56, child: FilledButton.icon(
        onPressed: consent.canScan ? () => Navigator.pushReplacementNamed(context, AppRoutes.radar) : null,
        icon: const Icon(Icons.radar_rounded),
        label: Text(consent.canScan ? 'INICIAR PRIMEIRO SCAN' : 'SCAN BLOQUEADO'),
      )),
      const SizedBox(height: 8),
      Center(child: TextButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.privacy),
        child: const Text('ABRIR CENTRAL DE CONTROLE'),
      )),
    ]),
  );
}

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({required this.item, required this.enabled, required this.onChanged, required this.onDetails});
  final ConsentItem item; final bool enabled; final ValueChanged<bool> onChanged; final VoidCallback onDetails;
  @override Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 9),
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18),
      border: Border.all(color: enabled ? AppColors.red.withValues(alpha: .55) : AppColors.border)),
    child: ListTile(
      contentPadding: const EdgeInsets.fromLTRB(14, 5, 8, 5),
      leading: AppIconBadge(icon: item.requiredForScan ? Icons.account_balance_wallet_outlined : Icons.lock_open_outlined, size: 42),
      title: Row(children: [
        Expanded(child: Text(item.title, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w800))),
        if (item.requiredForScan) const Text('BASE', style: TextStyle(color: AppColors.red, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
      ]),
      subtitle: Text(item.description, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
      trailing: Switch(value: enabled, onChanged: onChanged),
      onTap: onDetails,
    ),
  );
}

class _MasterSwitch extends StatelessWidget {
  const _MasterSwitch({required this.enabled, required this.onChanged});
  final bool enabled; final ValueChanged<bool>? onChanged;
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 10, 12),
    decoration: BoxDecoration(color: AppColors.surfaceSoft, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
    child: Row(children: [
      AppIconBadge(icon: enabled ? Icons.radar_rounded : Icons.pause_circle_outline, size: 42),
      const SizedBox(width: 12),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Scanning', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w900)),
        SizedBox(height: 3),
        Text('Permite novos scans com as fontes autorizadas.', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
      ])),
      Switch(value: enabled, onChanged: onChanged),
    ]),
  );
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text}); final String text;
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(color: AppColors.black.withValues(alpha: .35), borderRadius: BorderRadius.circular(30), border: Border.all(color: AppColors.border)),
    child: Text(text, style: const TextStyle(color: AppColors.white, fontSize: 10, fontWeight: FontWeight.w800)),
  );
}
