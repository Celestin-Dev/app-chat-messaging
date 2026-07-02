import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_messaging/core/constants/colors.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Masquer status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Delay 3000ms
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted) return;

      context.goNamed('login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: SvgPicture.asset('assets/splash_screen.svg')),
    );
  }
}
