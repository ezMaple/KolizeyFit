import 'package:flutter/material.dart';

class StyledInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;

  const StyledInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Динамические параметры на основе ширины экрана
    final fontSize = screenWidth < 360 ? 18.0 : 20.0;
    final verticalPadding = screenWidth < 360 ? 10.0 : 14.0;
    final inputWidth = screenWidth * 0.9;

    return SizedBox(
      width: inputWidth,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: fontSize, height: 1.4, color: Colors.black),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xFFD9D7D0),
          contentPadding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: 16.0,
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
