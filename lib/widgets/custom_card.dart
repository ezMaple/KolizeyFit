import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  final String price;
  final String title;
  final bool showIcon;
  final VoidCallback? onIconTap;
  final String? imageUrl;
  final bool isNetworkImage;
  final int? productId;

  const CustomCard({
    super.key,
    required this.price,
    required this.title,
    this.showIcon = false,
    this.onIconTap,
    this.imageUrl,
    this.isNetworkImage = false,
    this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double imageSize = screenWidth * 0.3;
    final double cardHeight = screenWidth * 0.58;
    final double padding = screenWidth * 0.03;

    // Адаптивные размеры текста
    final double titleFontSize = screenWidth * 0.040;
    final double priceFontSize = screenWidth * 0.036;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: const Color(0xFF616161),
      child: SizedBox(
        height: cardHeight,
        child: Stack(
          children: [
            // Изображение (под волной)
            Positioned(
              top: screenWidth * 0.08,
              left: 0,
              right: 0,
              child: Center(
                child:
                    isNetworkImage && imageUrl != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl!,
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) =>
                                    const Icon(Icons.broken_image, size: 50),
                          ),
                        )
                        : SvgPicture.asset(
                          'assets/images/Man.svg',
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.contain,
                        ),
              ),
            ),

            // Волна поверх изображения
            Positioned(
              bottom: -10,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/vectorcard.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Галочка
            if (showIcon)
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: onIconTap,
                  child: SvgPicture.asset(
                    'assets/images/ticks.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),

            // Текст
            Positioned(
              bottom: padding * 1.5,
              left: padding,
              right: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: priceFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
