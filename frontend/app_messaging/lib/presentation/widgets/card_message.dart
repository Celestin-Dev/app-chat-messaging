import 'package:flutter/material.dart';
import 'package:app_messaging/presentation/widgets/card_profil.dart';
import 'package:app_messaging/core/constants/sizes.dart';

class CardMessage extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  const CardMessage({
    super.key,
    this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          // Avatar
          CardProfil(imageUrl: imageUrl, size: 50, isRandom: false),

          const SizedBox(width: 16),

          // Nom + message
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

                const SizedBox(height: 6),

                Text(
                  lastMessage,
                  style: const TextStyle(
                    fontSize: AppSizes.textSizeSmall,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Heure + Badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: AppSizes.textSizeSmall,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 12),

              if (unreadCount > 0)
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
