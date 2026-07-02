import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_messaging/core/constants/colors.dart';

class AppTheme {
  AppTheme._();

  static const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    // Barre de statut
    statusBarColor: AppColors.primary,
    statusBarIconBrightness: Brightness.light, // icônes claires
    statusBarBrightness: Brightness.dark, // pour iOS
    // Barre de navigation système (bas, Android)
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  );

  /// Applique le style des barres système
  static void applySystemUiStyle() {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  /// Thème clair de l'application, à passer à MaterialApp(theme: ...).
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: systemUiOverlayStyle,
      ),
    );
  }
}
