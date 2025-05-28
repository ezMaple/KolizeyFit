import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/api_service.dart';
import 'navigator/qr_code_modal_widget.dart';
import 'navigator/bottom_navigation_bar_widget.dart';
import '/views/home_screen.dart';
import '/views/profile_screen.dart';
import '/views/branches_screen.dart';
import '/views/cart_screen.dart';
import '../l10n/app_localizations.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  AppNavigationBarState createState() => AppNavigationBarState();
}

class AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const BranchesScreen(),
    const Center(child: Text('QR-код Screen Placeholder')),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showQrCode();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showQrCode() async {
    final local = AppLocalizations.of(context)!;

    try {
      final qrData = await ApiService.getQrData();
      final jsonData = jsonEncode(qrData);

      if (!mounted) return;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: const Color(0xFF3E3E3E),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return QrCodeModalWidget(data: jsonData);
        },
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${local.qrCodeGenerationError}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
