import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CartViewModel extends ChangeNotifier {
  List<dynamic> _items = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _unauthorized = false;

  List<dynamic> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get unauthorized => _unauthorized;

  Future<void> fetchCart() async {
    _isLoading = true;
    _errorMessage = null;
    _unauthorized = false;
    notifyListeners();

    try {
      final result = await ApiService.getCart();
      _items = List<Map<String, dynamic>>.from(result);
    } catch (e) {
      if (e is ApiException && e.statusCode == 401) {
        _unauthorized = true;
      } else {
        _errorMessage = e.toString();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void retry() {
    fetchCart();
  }
}
