import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BranchesViewModel extends ChangeNotifier {
  List<dynamic> _branches = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get branches => _branches;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchBranches() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _branches = await ApiService.getBranches();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void retry() {
    fetchBranches();
  }
}
