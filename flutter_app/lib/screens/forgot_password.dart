import 'package:flutter/material.dart';

import '../style/app_style.dart';
import 'screen_shell.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController();
  final emailFocus = FocusNode();

  @override
  void dispose() {
    email.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  void submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recovery flow ready for API integration.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ScreenShell(
        title: 'Reset password',
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'GET BACK',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.8,
                ),
              ),
              const Text(
                'IN CONTROL.',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 39,
                  fontWeight: FontWeight.w900,
                  height: .92,
                  letterSpacing: -2,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Enter your email and we will send recovery instructions.',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: email,
                focusNode: emailFocus,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.email],
                autocorrect: false,
                enableSuggestions: false,
                enableInteractiveSelection: true,
                onTap: () {
                  if (!emailFocus.hasFocus) emailFocus.requestFocus();
                },
                onSubmitted: (_) => submit(),
                style: const TextStyle(color: AppColors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: AppIconBadge(icon: Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: submit,
                  child: const Text('SEND RECOVERY EMAIL'),
                ),
              ),
            ],
          ),
        ),
      );
}
