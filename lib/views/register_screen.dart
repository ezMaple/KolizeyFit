import 'package:flutter/material.dart';
import '../widgets/header_widget.dart';
import '../widgets/custom_button.dart';
import '../utils/transition.dart';
import '../services/api_service.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/register/name_input.dart';
import '../widgets/register/email_input.dart';
import '../widgets/register/phone_input.dart';
import '../widgets/register/password_input.dart';
import '../widgets/app_scaffold.dart';
import '../l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _register() async {
    final local = AppLocalizations.of(context)!;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      _showError(local.fillAllFields);
      return;
    }

    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(email)) {
      _showError(local.invalidEmail);
      return;
    }

    if (phone.length < 10 || phone.length > 15) {
      _showError(local.invalidPhone);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final body = {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      };

      await ApiService.register(body);

      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(CustomSnackBar(message: local.registrationSuccess));
      navigateTo(context, '/login');
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(CustomSnackBar(message: message, isError: true));
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return AppScaffold(
      title: local.registerTitle,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HeaderWidget(
              title: local.registerTitle,
              alignment: TextAlign.center,
            ),
            const SizedBox(height: 20),
            NameInput(controller: _nameController),
            const SizedBox(height: 20),
            EmailInput(controller: _emailController),
            const SizedBox(height: 20),
            PhoneInput(controller: _phoneController),
            const SizedBox(height: 20),
            PasswordInput(
              controller: _passwordController,
              obscureText: _obscureText,
              onToggleVisibility: _togglePasswordVisibility,
            ),
            const SizedBox(height: 25),
            _isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                  text: local.registerButton,
                  onPressed: _register,
                ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(local.alreadyHaveAccount),
                GestureDetector(
                  onTap:
                      () => Navigator.pushReplacementNamed(context, '/login'),
                  child: Text(
                    local.loginLink,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
