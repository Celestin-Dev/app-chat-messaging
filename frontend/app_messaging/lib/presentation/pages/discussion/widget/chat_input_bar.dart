import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_messaging/core/constants/colors.dart';
import 'package:app_messaging/core/constants/sizes.dart';
import 'package:app_messaging/presentation/widgets/input_text.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSendPressed;
  final VoidCallback? onAddPressed;
  final VoidCallback? onCameraTap;
  final VoidCallback? onMicTap;
  final String hintText;

  const ChatInputBar({
    super.key,
    required this.controller,
    this.onSendPressed,
    this.onAddPressed,
    this.onCameraTap,
    this.onMicTap,
    this.hintText = 'Ecrire un message...',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultPadding,
          vertical: 8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add, color: AppColors.textPrimary),
            ),
            Expanded(
              child: InputText(
                label: hintText,
                controller: controller,
                variant: InputTextVariant.voiceCamera,
                onMicTap: onMicTap,
              ),
            ),
            const SizedBox(width: 8),
            _SendButton(onTap: onSendPressed),
          ],
        ),
      ),
    );
  }
}

/// Bouton d'envoi
class _SendButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _SendButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: AppSizes.inputFieldHeight,
        height: AppSizes.inputFieldHeight,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          CupertinoIcons.paperplane_fill,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
