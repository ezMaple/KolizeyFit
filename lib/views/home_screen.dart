import 'package:flutter/material.dart';
import '../widgets/header_widget.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_snack_bar.dart';
import '../services/api_service.dart';
import '../widgets/app_scaffold.dart';
import '../l10n/app_localizations.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final data = await ApiService.getProducts();
      setState(() {
        _products = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(CustomSnackBar(message: e.toString(), isError: true));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;
    final crossAxisCount = isWideScreen ? 3 : 2;
    final aspectRatio = isWideScreen ? 0.8 : 0.7;

    return AppScaffold(
      title: local.homeTitle,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(title: local.homeTitle, alignment: TextAlign.center),
            const SizedBox(height: 10),
            _isLoading
                ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
                : _products.isEmpty
                ? Expanded(
                  child: Center(child: Text(local.noAvailableSubscriptions)),
                )
                : Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final item = _products[index];
                      final imageUrl =
                          item['image_path'] != null
                              ? '${ApiService.baseUrl}${item['image_path']}'
                              : null;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => DetailsScreen(
                                    title: item['title'],
                                    price: '${item['price']} руб.',
                                    description: item['description'] ?? '',
                                    imageUrl: imageUrl,
                                    productId: item['id'],
                                  ),
                            ),
                          );
                        },
                        child: CustomCard(
                          title: item['title'],
                          price: '${item['price']} руб.',
                          imageUrl: imageUrl,
                          isNetworkImage: imageUrl != null,
                          productId: item['id'],
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
