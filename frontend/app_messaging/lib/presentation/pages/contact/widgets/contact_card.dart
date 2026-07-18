import 'package:app_messaging/core/constants/sizes.dart';
import 'package:app_messaging/presentation/widgets/card_profil.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String email;
  final String phoneNumber;

  const ContactCard({
    super.key,
    this.imageUrl = '',
    required this.name,
    required this.email,
    this.phoneNumber = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CardProfil(imageUrl: imageUrl, size: 50),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: AppSizes.textSizeMedium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: AppSizes.textSizeSmall,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  phoneNumber,
                  style: const TextStyle(
                    fontSize: AppSizes.textSizeSmall,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
