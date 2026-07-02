import 'package:flutter/material.dart';
import 'package:app_messaging/core/theme/app_theme.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Applique une seule fois le style des barres système (status bar + barre
  // de navigation Android) au démarrage de l'app.
  AppTheme.applySystemUiStyle();

  runApp(const MyApp());
}
