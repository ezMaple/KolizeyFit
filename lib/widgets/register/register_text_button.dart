import 'package:flutter/material.dart';
import 'package:kolizeyfit/l10n/app_localizations.dart';

class RegisterTextButton extends StatelessWidget {
  const RegisterTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    // Динамический размер шрифта
    final fontSize = screenWidth < 360 ? 15.0 : 17.0;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${local.noAccount} ',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white, // белый текст
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/register'),
            child: Text(
              local.registerButton,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.yellow, // жёлтый текст
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
