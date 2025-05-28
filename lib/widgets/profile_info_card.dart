import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileInfoCard extends StatelessWidget {
  final ImageProvider avatar;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileInfoCard({
    super.key,
    required this.avatar,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Получаем размеры экрана
    final double screenWidth = MediaQuery.of(context).size.width;

    // Определяем размеры адаптивно
    double avatarRadius = screenWidth * 0.08;
    double fontSize = screenWidth * 0.045;
    double iconSize = screenWidth * 0.10; // Уменьшил размер иконки

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700], // Цвет карточки
          padding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.04,
            horizontal: screenWidth * 0.05,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Радиус скругления
          ),
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: avatarRadius, // Адаптивный размер аватара
                    backgroundImage: avatar,
                  ),
                  SizedBox(width: screenWidth * 0.04), // Отступ между аватаром и текстом
                  // Ограничиваем ширину текста для предотвращения переполнения
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis, // Многоточие при переполнении
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize, // Адаптивный размер шрифта
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.01), // Отступ между заголовком и подзаголовком
                        Text(
                          subtitle,
                          overflow: TextOverflow.ellipsis, // Многоточие при переполнении
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: fontSize * 0.9, // Чуть меньше подзаголовок
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.02), // Небольшой отступ перед иконкой
            SvgPicture.asset(
              'assets/images/enter.svg',
              height: iconSize,
              width: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
