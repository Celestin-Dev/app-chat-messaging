import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:app_messaging/core/constants/colors.dart';
import 'package:app_messaging/core/services/token_storage_service.dart';
import 'package:app_messaging/core/services/network_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Android
        statusBarBrightness: Brightness.dark, // iOS
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    _checkAuthAndRedirect();
  }

  Future<void> _checkAuthAndRedirect() async {
    final hasInternet = await NetworkService.hasInternetConnection();

    if (!mounted) return;

    if (!hasInternet) {
      context.goNamed("connection_failed");
      return;
    }

    final tokenCheck = TokenStorageService.instance.getToken();

    final results = await Future.wait([
      tokenCheck,
      Future.delayed(const Duration(milliseconds: 800)),
    ]);

    final token = results[0] as String?;

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      context.goNamed("messages");
    } else {
      context.goNamed("login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset(
            'assets/splash_screen.svg',
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}
