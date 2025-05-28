import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final TextAlign alignment;
  final double? fontSize; // ⬅️ Новый параметр для кастомизации размера шрифта

  const HeaderWidget({
    super.key,
    required this.title,
    required this.alignment,
    this.fontSize, // ⬅️ Необязательный параметр
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final adaptiveFontSize = fontSize ?? (screenWidth * 0.08);

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Text(
        title,
        textAlign: alignment,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: adaptiveFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
