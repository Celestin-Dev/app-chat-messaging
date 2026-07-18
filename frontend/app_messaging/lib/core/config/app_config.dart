import 'dart:io';

class AppConfig {
  AppConfig._();

  static const String _prodBaseUrl = "https://app-chat-messagint.onrender.com";

  static String get _devBaseUrl {
    if (Platform.isAndroid) return 'http://10.0.2.2:8080';
    return 'http://localhost:8080';
  }

  static const bool useProd = false;

  static get baseUrl => useProd ? _prodBaseUrl : _devBaseUrl;
}
