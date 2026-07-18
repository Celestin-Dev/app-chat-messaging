import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  TokenStorageService._internal();

  static final TokenStorageService instance = TokenStorageService._internal();

  static const _tokenKey = 'auth_token';

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  /// Sauvegarde le token après login/register/Google Sign-In
  Future<void> saveToken(String token) {
    return _storage.write(key: _tokenKey, value: token);
  }

  /// Récupère le token stocké, ou null s'il n'existe pas
  Future<String?> getToken() {
    return _storage.read(key: _tokenKey);
  }

  /// Supprime le token (déconnexion)
  Future<void> deleteToken() {
    return _storage.delete(key: _tokenKey);
  }

  /// Vérifie rapidement si un token existe, sans le lire en entier
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
