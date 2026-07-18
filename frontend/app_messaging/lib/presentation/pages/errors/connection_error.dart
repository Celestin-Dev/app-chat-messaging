import 'package:app_messaging/core/constants/colors.dart';
import 'package:app_messaging/core/constants/sizes.dart';
import 'package:app_messaging/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ConnectionError extends StatefulWidget {
  const ConnectionError({super.key});

  @override
  State<ConnectionError> createState() => _ConnectionError();
}

class _ConnectionError extends State<ConnectionError> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: 10),
              const Text(
                "Pas de connexion internet",
                style: TextStyle(
                  fontSize: AppSizes.textSizeLarge,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Vérifiez votre connexion Wi-Fi ou vos données mobiles, puis réessayez.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.textSizeMedium,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              ButtonPrimary(
                text: "Réessayer",
                onPressed: () {
                  context.goNamed("splash");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
