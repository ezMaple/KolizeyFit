import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_snack_bar.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class DetailsScreen extends StatelessWidget {
  final String price;
  final String title;
  final String description;
  final String? imageUrl;
  final int? productId;

  const DetailsScreen({
    super.key,
    required this.price,
    required this.title,
    required this.description,
    this.imageUrl,
    this.productId,
  });

  Future<void> _addToCart(BuildContext context) async {
    final local = AppLocalizations.of(context)!;

    try {
      if (productId != null) {
        await ApiService.addToCart(productId!);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(CustomSnackBar(message: local.addedToCartSuccess));
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            CustomSnackBar(message: local.productIdNotSet, isError: true),
          );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(CustomSnackBar(message: e.toString(), isError: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    final double imageHeight = size.height * 0.3;
    final double titleFont = screenWidth * 0.07;
    final double priceFont = screenWidth * 0.06;
    final double descFont = screenWidth * 0.05;
    final double buttonFont = screenWidth * 0.045;

    return Scaffold(
      body: Stack(
        children: [
          // Волна внизу
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Expanded(child: Container()),
                Image.asset(
                  'assets/images/vectordetails.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Заголовок + назад
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              local.detailsTitle,
                              style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: SvgPicture.asset(
                                'assets/images/back.svg',
                                width: 50,
                                height: 50,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Изображение
                      imageUrl != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl!,
                              height: imageHeight,
                              fit: BoxFit.contain,
                              errorBuilder:
                                  (_, __, ___) =>
                                      const Icon(Icons.broken_image, size: 100),
                            ),
                          )
                          : SvgPicture.asset(
                            'assets/images/Man.svg',
                            height: imageHeight,
                          ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),

                      // Контент с прокруткой
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                        fontSize: titleFont,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                          255,
                                          95,
                                          89,
                                          89,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      price,
                                      style: TextStyle(
                                        fontSize: priceFont,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromARGB(
                                          179,
                                          39,
                                          37,
                                          37,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      description,
                                      style: TextStyle(
                                        fontSize: descFont,
                                        color: const Color.fromARGB(
                                          179,
                                          39,
                                          37,
                                          37,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Кнопка
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16.0,
                                bottom: 24.0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => _addToCart(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF616161),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    local.addToCartButton,
                                    style: TextStyle(
                                      fontSize: buttonFont,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
