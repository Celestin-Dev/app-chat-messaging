import 'dart:math';
import 'package:app_messaging/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CardProfil extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const CardProfil({super.key, this.imageUrl, this.size = 60});

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    if (hasImage) {
      return ClipOval(
        child: Image.network(
          imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _defaultAvatar(),
        ),
      );
    }

    return _defaultAvatar();
  }

  Widget _defaultAvatar() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors
            .randomColors[Random().nextInt(AppColors.randomColors.length)],
      ),
      child: Icon(Icons.person, color: Colors.white, size: size * 0.7),
    );
  }
}
