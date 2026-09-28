import 'package:flutter/material.dart';
import '../core/consent_store.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class PrivacyCenterScreen extends StatefulWidget {
  const PrivacyCenterScreen({super.key});
  @override State<PrivacyCenterScreen> createState() => _PrivacyCenterScreenState();
}

class _PrivacyCenterScreenState extends State<PrivacyCenterScreen> {
  final consent = ConsentStore.instance;
  @override void initState() { super.initState(); consent.addListener(_refresh); }
  @override void dispose() { consent.removeListener(_refresh); super.dispose(); }
  void _refresh() { if (mounted) setState(() {}); }

  Future<void> _revokeAll() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Revogar todas as permissões?'),
        content: const Text('Novos scans serão bloqueados e todas as fontes serão desligadas. Os dados já armazenados não serão apagados por esta ação.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Revogar tudo')),
        ],
      ),
    );
    if (ok == true) consent.revokeAll();
  }

  @override Widget build(BuildContext context) => ScreenShell(
    title: 'Privacy Center', showRadar: false,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionCard(title: 'Seu controle', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Nada deve ser analisado sem sua autorização.',
          style: TextStyle(color: AppColors.white, fontSize: 21, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text('Desligue uma fonte individualmente ou pause todos os scans. Permissão e exclusão de dados são controles diferentes.',
          style: TextStyle(color: AppColors.textMuted, height: 1.45)),
        const SizedBox(height: 18),
        Row(children: [
          Expanded(child: _Stat(label: 'FONTES', value: consent.grantedCount.toString())),
          const SizedBox(width: 8),
          Expanded(child: _Stat(label: 'SCAN', value: consent.scanningEnabled ? 'ON' : 'OFF')),
        ]),
      ])),
      const SizedBox(height: 14),
      _GlobalScan(enabled: consent.scanningEnabled, onChanged: consent.setScanning),
      const SizedBox(height: 18),
      const Text('FONTES DE DADOS', style: TextStyle(color: AppColors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
      const SizedBox(height: 10),
      ...ConsentStore.items.map((item) => _Row(item: item, enabled: consent.isGranted(item.key), onChanged: (v) => consent.setGrant(item.key, v))),
      const SizedBox(height: 18),
      OutlinedButton.icon(onPressed: _revokeAll, icon: const Icon(Icons.block_outlined), label: const Text('REVOGAR TODAS AS PERMISSÕES'),
        style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 52), foregroundColor: AppColors.white, side: const BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
      const SizedBox(height: 10),
      OutlinedButton.icon(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('A exclusão definitiva será conectada ao backend seguro.'))),
        icon: const Icon(Icons.delete_outline), label: const Text('EXCLUIR DADOS ARMAZENADOS'),
        style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 52), foregroundColor: AppColors.white, side: const BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
      const SizedBox(height: 10),
      const Text('Nesta versão, as permissões são controladas em sessão. Persistência segura, revogação no servidor e conectores reais entram com o backend.',
        style: TextStyle(color: AppColors.textMuted, fontSize: 11, height: 1.45)),
    ]),
  );
}

class _GlobalScan extends StatelessWidget {
  const _GlobalScan({required this.enabled, required this.onChanged});
  final bool enabled; final ValueChanged<bool> onChanged;
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: enabled ? AppColors.surfaceSoft : AppColors.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: enabled ? AppColors.red.withValues(alpha: .55) : AppColors.border)),
    child: Row(children: [
      AppIconBadge(icon: enabled ? Icons.radar_rounded : Icons.pause_circle_outline, size: 44),
      const SizedBox(width: 12),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Todos os scans', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w900)),
        SizedBox(height: 3),
        Text('Desligue para impedir novas análises.', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
      ])),
      Switch(value: enabled, onChanged: onChanged),
    ]),
  );
}

class _Row extends StatelessWidget {
  const _Row({required this.item, required this.enabled, required this.onChanged});
  final ConsentItem item; final bool enabled; final ValueChanged<bool> onChanged;
  @override Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
    child: SwitchListTile(
      value: enabled, onChanged: onChanged,
      title: Text(item.title, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700)),
      subtitle: Text(item.description, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
      secondary: Icon(enabled ? Icons.lock_open_rounded : Icons.lock_outline_rounded, color: enabled ? AppColors.success : AppColors.textMuted),
    ),
  );
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label; final String value;
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(color: AppColors.black.withValues(alpha: .35), borderRadius: BorderRadius.circular(14)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 9, letterSpacing: 1)),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w900)),
    ]),
  );
}
