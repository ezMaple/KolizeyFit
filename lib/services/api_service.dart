import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => message;
}

class ApiService {
  static const String baseUrl = 'http://81.31.247.125:8000';
  static String? _token;

  static void updateToken(String token) {
    _token = token;
  }

  static Map<String, String> _headers({bool withAuth = false}) {
    final headers = {'Content-Type': 'application/json'};
    if (withAuth && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  static bool get hasToken => _token?.isNotEmpty ?? false;

  // AUTH
  static Future<void> persistToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    _token = token;
  }

  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      _token = token;
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _token = null;
  }

  static Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': email, 'password': password},
    );

    final token = _handleResponse(response, extractToken: true);
    _token = token;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);

    return token;
  }

  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  // PROFILE
  static Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile/'),
      headers: _headers(withAuth: true),
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? email,
    String? phone,
    File? avatar,
  }) async {
    final uri = Uri.parse('$baseUrl/profile/');
    final request = http.MultipartRequest('PUT', uri);

    if (_token != null) {
      request.headers['Authorization'] = 'Bearer $_token';
    }

    if (name != null) request.fields['name'] = name;
    if (email != null) request.fields['email'] = email;
    if (phone != null) request.fields['phone'] = phone;

    if (avatar != null) {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', avatar.path),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }

  // PRODUCTS
  static Future<List<dynamic>> getProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/'),
      headers: _headers(),
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> getProduct(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/$id'),
      headers: _headers(),
    );
    return _handleResponse(response);
  }

  // CART
  static Future<List<dynamic>> getCart() async {
    final response = await http.get(
      Uri.parse('$baseUrl/cart/'),
      headers: _headers(withAuth: true),
    );
    return _handleResponse(response);
  }

  static Future<void> addToCart(int productId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cart/'),
      headers: _headers(withAuth: true),
      body: jsonEncode({'product_id': productId}),
    );
    _handleResponse(response);
  }

  static Future<void> removeFromCart(int productId) async {
    final request =
        http.Request('DELETE', Uri.parse('$baseUrl/cart/'))
          ..headers.addAll(_headers(withAuth: true))
          ..body = jsonEncode({'product_id': productId});
    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    _handleResponse(response);
  }

  static Future<bool> payCart() async {
    final url = Uri.parse('$baseUrl/cart/pay');

    final response = await http.post(url, headers: _headers(withAuth: true));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // PARAMETERS
  static Future<Map<String, dynamic>> getParameters() async {
    final response = await http.get(
      Uri.parse('$baseUrl/parameters/'),
      headers: _headers(withAuth: true),
    );
    return _handleResponse(response);
  }

  static Future<void> createParameters(Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/parameters/'),
      headers: _headers(withAuth: true),
      body: jsonEncode(body),
    );
    _handleResponse(response);
  }

  static Future<void> updateParameters(Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/parameters/'),
      headers: _headers(withAuth: true),
      body: jsonEncode(body),
    );
    _handleResponse(response);
  }

  // BRANCHES
  static Future<List<dynamic>> getBranches() async {
    final response = await http.get(
      Uri.parse('$baseUrl/branches/'),
      headers: _headers(),
    );
    return _handleResponse(response);
  }

  // QR-код
  static Future<Map<String, dynamic>> getQrData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile/qr-data'),
      headers: _headers(withAuth: true),
    );
    return _handleResponse(response);
  }

  // ---------- Общая обработка ответов ----------

  static dynamic _handleResponse(
    http.Response response, {
    bool extractToken = false,
  }) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (statusCode >= 200 && statusCode < 300) {
      return extractToken ? body['access_token'] : body;
    } else {
      String message = 'Произошла ошибка';

      if (body is Map) {
        if (body['detail'] is String) {
          message = body['detail'];
        } else if (body['detail'] is List) {
          message = body['detail']
              .map((e) => '${e['loc'].last}: ${e['msg']}')
              .join('\n');
        }
      }

      throw ApiException(statusCode, message);
    }
  }
}
