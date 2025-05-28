import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final currentLocale = provider.locale;

    return Padding(
      padding: const EdgeInsets.only(right: 10.0), // ⬅️ отступ справа
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          value: currentLocale,
          icon: const Icon(
            Icons.language,
            color: Colors.white,
          ), // 🌐 иконка белая
          dropdownColor: Colors.grey[900], // цвет меню
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0, // ⬅️ увеличен шрифт выбранного элемента
          ),
          onChanged: (Locale? newLocale) {
            if (newLocale != null) {
              provider.setLocale(newLocale);
            }
          },
          items:
              L10n.all.map((locale) {
                final label = L10n.getLanguageName(locale.languageCode);
                return DropdownMenuItem(value: locale, child: Text(label));
              }).toList(),
        ),
      ),
    );
  }
}
