import 'package:app_messaging/core/constants/colors.dart';
import 'package:app_messaging/core/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Type de champ à afficher
enum InputTextVariant {
  simple, // juste le placeholder
  search, // icône loupe à gauche
  passwordVisible, // mot de passe visible + icône oeil ouvert
  passwordHidden, // mot de passe caché + icône oeil barré
  voiceCamera, // icônes caméra + micro à droite
}

class InputText extends StatefulWidget {
  final String label; // utilisé comme hintText
  final TextEditingController controller;
  final InputTextVariant variant;
  final bool isEmail;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onCameraTap;
  final VoidCallback? onMicTap;

  static const double borderColorValue = 0xFF888888;
  static const Color borderColor = AppColors.divider;
  static const Color fillColor = AppColors.socialButtonBg;
  static const double fieldHeight = AppSizes.inputFieldHeight;

  const InputText({
    super.key,
    required this.label,
    required this.controller,
    this.variant = InputTextVariant.simple,
    this.isEmail = false,
    this.onChanged,
    this.onCameraTap,
    this.onMicTap,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  // Pour le variant passwordVisible / passwordHidden : permet de basculer l'affichage
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.variant == InputTextVariant.passwordHidden;
  }

  bool get _isPasswordVariant =>
      widget.variant == InputTextVariant.passwordVisible ||
      widget.variant == InputTextVariant.passwordHidden;

  Widget? get _prefixIcon {
    if (widget.variant == InputTextVariant.search) {
      return const Icon(Icons.search, color: Colors.grey);
    }
    return null;
  }

  Widget? get _suffixIcon {
    if (_isPasswordVariant) {
      return IconButton(
        splashRadius: 18,
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    if (widget.variant == InputTextVariant.voiceCamera) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            splashRadius: 18,
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            onPressed: widget.onCameraTap,
          ),
          IconButton(
            splashRadius: 18,
            icon: const Icon(Icons.mic_none, color: Colors.grey),
            onPressed: widget.onMicTap,
          ),
        ],
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppSizes.defaultBorderRadius);

    return SizedBox(
      height: InputText.fieldHeight,
      child: TextField(
        controller: widget.controller,
        obscureText: _isPasswordVariant ? _obscureText : false,
        onChanged: widget.onChanged,
        keyboardType: widget.isEmail
            ? TextInputType.emailAddress
            : TextInputType.text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        decoration: InputDecoration(
          hintText: widget.label,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: InputText.fillColor,
          prefixIcon: _prefixIcon,
          suffixIcon: _suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: InputText.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: InputText.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: InputText.borderColor,
              width: 1.4,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: InputText.borderColor),
          ),
        ),
      ),
    );
  }
}

/// Écran de démonstration reproduisant les 5 variantes de la maquette.
class InputTextDemoScreen extends StatelessWidget {
  const InputTextDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c1 = TextEditingController();
    final c2 = TextEditingController();
    final c3 = TextEditingController();
    final c4 = TextEditingController();
    final c5 = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              InputText(
                label: 'example@email.com',
                controller: c1,
                variant: InputTextVariant.simple,
                isEmail: true,
              ),
              const SizedBox(height: 24),
              InputText(
                label: 'example@email.com',
                controller: c2,
                variant: InputTextVariant.search,
                isEmail: true,
              ),
              const SizedBox(height: 24),
              InputText(
                label: 'example@email.com',
                controller: c3,
                variant: InputTextVariant.passwordVisible,
                isEmail: true,
              ),
              const SizedBox(height: 24),
              InputText(
                label: 'example@email.com',
                controller: c4,
                variant: InputTextVariant.passwordHidden,
                isEmail: true,
              ),
              const SizedBox(height: 24),
              InputText(
                label: 'example@email.com',
                controller: c5,
                variant: InputTextVariant.voiceCamera,
                isEmail: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
