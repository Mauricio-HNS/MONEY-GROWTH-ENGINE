import 'package:flutter/material.dart';

import '../style/app_style.dart';
import 'screen_shell.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) => ScreenShell(
        title: 'Reset password',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter your email and we will send recovery instructions.', style: TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.5)),
            const SizedBox(height: 26),
            TextField(controller: email, keyboardType: TextInputType.emailAddress, style: const TextStyle(color: AppColors.white), decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined))),
            const SizedBox(height: 22),
            SizedBox(width: double.infinity, height: 52, child: FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recovery flow ready for API integration.'))), child: const Text('Send recovery email'))),
          ],
        ),
      );
}
