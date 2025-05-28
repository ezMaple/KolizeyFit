import 'package:flutter/material.dart';
import '../widgets/header_widget.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/error_message.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import '../widgets/app_scaffold.dart';
import '../l10n/app_localizations.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<dynamic>> _cartFuture;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  void _loadCart() {
    _cartFuture = ApiService.getCart();
  }

  void _retry() {
    setState(() => _loadCart());
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(CustomSnackBar(message: message));
  }

  void _navigateToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  double _calculateTotal(List<dynamic> items) {
    return items.fold(0.0, (sum, item) {
      final product = item['product'];
      final price = product['price'] ?? 0.0;
      final quantity = product['quantity'] ?? 1;
      return sum + price * quantity;
    });
  }

  Future<void> _handlePayment() async {
    final local = AppLocalizations.of(context)!;
    final cartItems = await _cartFuture;
    final total = _calculateTotal(cartItems);

    final itemNames =
        cartItems.map<String>((item) {
          final product = item['product'];
          return '• ${product['title']}';
        }).toList();

    final success = await ApiService.payCart();
    if (success) {
      await NotificationService.showNotification(
        title: local.paymentSuccess,
        body: local.cartTotal(total.toStringAsFixed(2)),
        lines: itemNames,
      );
      _retry();
    } else {
      await NotificationService.showNotification(
        title: local.paymentError,
        body: '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;
    final fontSize = screenWidth * 0.045;
    final crossAxisCount = isWideScreen ? 3 : 2;

    return AppScaffold(
      title: local.cartTitle,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(title: local.cartTitle, alignment: TextAlign.center),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _cartFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    final error = snapshot.error;
                    if (error is ApiException && error.statusCode == 401) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              local.loginRequiredToViewCart,
                              style: TextStyle(fontSize: fontSize),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _navigateToLogin,
                              child: Text(
                                local.loginButton,
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ErrorMessage(
                        message: '${local.cartLoadError}:\n${error.toString()}',
                        onRetry: _retry,
                      );
                    }
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        local.cartIsEmpty,
                        style: TextStyle(fontSize: fontSize),
                      ),
                    );
                  }

                  final items = snapshot.data!;
                  final total = _calculateTotal(items);

                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: isWideScreen ? 0.8 : 0.7,
                              ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            final product = item['product'];
                            final imageUrl =
                                product['image_path'] != null
                                    ? '${ApiService.baseUrl}${product['image_path']}'
                                    : null;

                            return CustomCard(
                              title: product['title'],
                              price: '${product['price']} руб.',
                              imageUrl: imageUrl,
                              isNetworkImage: imageUrl != null,
                              showIcon: true,
                              onIconTap: () async {
                                await ApiService.removeFromCart(product['id']);
                                _showSnackbar(local.removedFromCart);
                                _retry();
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            local.cartTotal(total.toStringAsFixed(2)),
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _handlePayment,
                            child: Text(
                              local.payButton,
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                        ],
                      ),
                    ],
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
