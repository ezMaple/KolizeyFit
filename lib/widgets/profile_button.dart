import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const ProfileButton({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700], // Цвет кнопки
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Радиус скругления
          ),
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: Colors.white)),
            SvgPicture.asset(
              'assets/images/enter.svg', // Путь к SVG файлу
              height: 40,
              width: 40,
            ),
          ],
        ),
      ),
    );
  }
}
