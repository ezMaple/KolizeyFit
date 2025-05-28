import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  const PasswordInput({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Динамически вычисляем шрифт и размеры отступов
    final fontSize = screenWidth < 360 ? 18.0 : 20.0;
    final verticalPadding = screenWidth < 360 ? 10.0 : 14.0;

    return SizedBox(
      width: screenWidth * 0.9, // 90% ширины экрана
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: fontSize, height: 1.4, color: Colors.black),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: 'Пароль',
          filled: true,
          fillColor: const Color(0xFFD9D7D0),
          contentPadding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: 16.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.black54,
            ),
            onPressed: onToggleVisibility,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black54, width: 1.5),
          ),
        ),
      ),
    );
  }
}
