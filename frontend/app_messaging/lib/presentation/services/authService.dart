import 'dart:convert';

import 'package:app_messaging/core/config/app_config.dart';
import 'package:app_messaging/core/services/token_storage_service.dart';
import 'package:http/http.dart' as http;

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService {
  final http.Client _client = http.Client();
  Uri _uri(String path) => Uri.parse('${AppConfig.baseUrl}$path');

  //login classique
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      _uri('/api/auth/login'),
      headers: {'ContentType': 'application/json'},
      body: jsonEncode({'username': email, 'password': password}),
    );
    return _handleAuthResponse(response);
  }

  // Inscription classique
  Future<String> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      _uri('/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    return _handleAuthResponse(response);
  }

  // Continuer avec google
  Future<String> loginWithGoogle(String idToken) async {
    final response = await _client.post(
      _uri('/api/auth/google'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idToken': idToken}),
    );
    return _handleAuthResponse(response);
  }

  Future<String> _handleAuthResponse(http.Response response) async {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final token = data['token'] as String?;

      if (token == null || token.isEmpty) {
        throw AuthException("Response invalide su serveur !");
      }

      await TokenStorageService.instance.saveToken(token);

      return token;
    }

    // recupere un message d'erreur lisible renvoyé par backend
    String message = 'Une erreur est survenue (${response.statusCode})';

    try {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      message = data['message'] as String? ?? message;
    } catch (_) {}
    throw AuthException(message);
  }
}
