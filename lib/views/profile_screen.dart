import 'package:flutter/material.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/profile_button.dart';
import '../services/api_service.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/language_selector.dart'; // 👈 импорт селектора языка
import '../l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String phone = '';
  String? avatarUrl;
  bool isLoading = true;
  bool _profileLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_profileLoaded) {
      _loadProfile();
      _profileLoaded = true;
    }
  }

  Future<void> _loadProfile() async {
    final local = AppLocalizations.of(context)!;

    try {
      final profile = await ApiService.getProfile();
      setState(() {
        name = profile['name'] ?? '';
        phone = profile['phone'] ?? '';
        avatarUrl = profile['avatar_path'];
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          CustomSnackBar(message: local.profileLoadError, isError: true),
        );
    }
  }

  Future<void> _logout() async {
    await ApiService.logout(); // Очистка токена и SharedPreferences
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.profileTitle),
        actions: const [
          LanguageSelector(), // 👈 добавляем селектор языка
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileInfoCard(
                      avatar:
                          avatarUrl != null
                              ? NetworkImage(
                                '${ApiService.baseUrl}$avatarUrl?t=${DateTime.now().millisecondsSinceEpoch}',
                              )
                              : const AssetImage('assets/images/Ava.png')
                                  as ImageProvider,
                      title: name,
                      subtitle: phone,
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/editProfile',
                        );
                        if (result == true) {
                          _loadProfile();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    ProfileButton(
                      title: local.myParametersButton,
                      onTap: () => Navigator.pushNamed(context, '/parameters'),
                    ),
                    ProfileButton(
                      title: local.notificationSettingsButton,
                      onTap: () {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            CustomSnackBar(message: local.notImplemented),
                          );
                      },
                    ),
                    ProfileButton(
                      title: local.deleteAccountButton,
                      onTap: () {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            CustomSnackBar(message: local.notImplemented),
                          );
                      },
                    ),
                    if (ApiService.hasToken)
                      ProfileButton(title: local.logoutButton, onTap: _logout),
                  ],
                ),
      ),
    );
  }
}
