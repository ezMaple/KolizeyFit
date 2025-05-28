import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import '../widgets/app_scaffold.dart';
import '../widgets/header_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/register/email_input.dart';
import '../widgets/register/password_input.dart';
import '../widgets/register/register_text_button.dart';
import '../utils/transition.dart';
import '../services/api_service.dart';
import '../widgets/custom_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _login() async {
    final local = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          CustomSnackBar(
            message: local.enterEmailAndPassword, // Локализовано
            isError: true,
          ),
        );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final token = await ApiService.login(email, password);
      ApiService.updateToken(token);

      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          CustomSnackBar(
            message: local.loginSuccess, // Локализовано
          ),
        );
      navigateTo(context, '/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          CustomSnackBar(
            message:
                e.toString(), // можно дополнительно локализовать типовые ошибки
            isError: true,
          ),
        );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return AppScaffold(
      title: local.loginTitle,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HeaderWidget(title: local.loginTitle, alignment: TextAlign.center),
            const SizedBox(height: 30),
            EmailInput(controller: _emailController),
            const SizedBox(height: 20),
            PasswordInput(
              controller: _passwordController,
              obscureText: _obscureText,
              onToggleVisibility: _togglePasswordVisibility,
            ),
            const SizedBox(height: 20),
            const RegisterTextButton(),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : CustomButton(text: local.loginButton, onPressed: _login),
          ],
        ),
      ),
    );
  }
}
