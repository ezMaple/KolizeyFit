import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../l10n/app_localizations.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onTap,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.grey,
      backgroundColor: const Color(0xFF3E3E3E),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/home.svg',
            width: 30,
            height: 30,
            colorFilter:
                selectedIndex == 0
                    ? const ColorFilter.mode(Colors.yellow, BlendMode.srcIn)
                    : null,
          ),
          label: local.navHome,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/filial.svg',
            width: 30,
            height: 30,
            colorFilter:
                selectedIndex == 1
                    ? const ColorFilter.mode(Colors.yellow, BlendMode.srcIn)
                    : null,
          ),
          label: local.navBranches,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner, size: 40), // Фиктивный иконка
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/basket.svg',
            width: 30,
            height: 30,
            colorFilter:
                selectedIndex == 3
                    ? const ColorFilter.mode(Colors.yellow, BlendMode.srcIn)
                    : null,
          ),
          label: local.navCart,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/profile.svg',
            width: 30,
            height: 30,
            colorFilter:
                selectedIndex == 4
                    ? const ColorFilter.mode(Colors.yellow, BlendMode.srcIn)
                    : null,
          ),
          label: local.navProfile,
        ),
      ],
    );
  }
}
