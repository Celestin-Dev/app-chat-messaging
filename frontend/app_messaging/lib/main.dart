import 'package:flutter/material.dart';
import 'package:app_messaging/core/theme/app_theme.dart';
import 'app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Applique une seule fois le style des barres système (status bar + barre
  // de navigation Android) au démarrage de l'app.
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  AppTheme.applySystemUiStyle();

  runApp(const MyApp());
}
