import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../l10n/app_localizations.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Center(
      child: SvgPicture.asset(
        'assets/images/KolizeyLogo.svg',
        width: 250,
        height: 250,
        fit: BoxFit.contain,
        semanticsLabel: local.kolizeyLogoAlt,
      ),
    );
  }
}
