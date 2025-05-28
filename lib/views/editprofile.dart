import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/register/name_input.dart';
import '../widgets/register/email_input.dart';
import '../widgets/register/phone_input.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snack_bar.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';
import '../widgets/language_selector.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  File? _avatarFile;
  bool _isLoading = false;
  String? _avatarUrl;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loadProfile();
      _loaded = true;
    }
  }

  Future<void> _loadProfile() async {
    final local = AppLocalizations.of(context)!;

    try {
      final profile = await ApiService.getProfile();
      if (!mounted) return;
      _nameController.text = profile['name'] ?? '';
      _emailController.text = profile['email'] ?? '';
      _phoneController.text = profile['phone'] ?? '';
      setState(() {
        _avatarUrl = profile['avatar_path'];
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(message: local.profileLoadError, isError: true),
      );
    }
  }

  Future<void> _pickAvatar() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _avatarFile = File(picked.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final local = AppLocalizations.of(context)!;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
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
      final oldProfile = await ApiService.getProfile();

      await ApiService.updateProfile(
        name: name,
        email: email,
        phone: phone,
        avatar: _avatarFile,
      );

      if (!mounted) return;

      final emailChanged = email != oldProfile['email'];

      if (emailChanged) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(CustomSnackBar(message: local.emailChangedLoginAgain));

        ApiService.updateToken('');
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(CustomSnackBar(message: local.profileUpdated));
        Navigator.pop(context, true);
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(CustomSnackBar(message: message, isError: true));
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.settingsTitle),
        actions: const [LanguageSelector()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickAvatar,
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    _avatarFile != null
                        ? FileImage(_avatarFile!)
                        : _avatarUrl != null
                        ? NetworkImage(
                          '${ApiService.baseUrl}$_avatarUrl?t=${DateTime.now().millisecondsSinceEpoch}',
                        )
                        : const AssetImage('assets/images/Ava.png')
                            as ImageProvider,
              ),
            ),
            const SizedBox(height: 15),
            NameInput(controller: _nameController),
            const SizedBox(height: 15),
            EmailInput(controller: _emailController),
            const SizedBox(height: 15),
            PhoneInput(controller: _phoneController),
            const SizedBox(height: 15),
            _isLoading
                ? const CircularProgressIndicator()
                : CustomButton(text: local.saveButton, onPressed: _saveProfile),
          ],
        ),
      ),
    );
  }
}
