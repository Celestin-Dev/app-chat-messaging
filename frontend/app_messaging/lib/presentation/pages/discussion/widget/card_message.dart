import 'package:app_messaging/core/enum/message_bubble_variant.dart';
import 'package:app_messaging/presentation/models/conversation.dart';
import 'package:app_messaging/presentation/widgets/card_profil.dart';
import 'package:app_messaging/core/constants/colors.dart';
import 'package:app_messaging/core/constants/sizes.dart';
import 'package:flutter/material.dart';

class CardMessage extends StatelessWidget {
  final Conversation conversation;
  final MessageBubbleVariant variant;

  const CardMessage({
    super.key,
    required this.conversation,
    this.variant = MessageBubbleVariant.received,
  });

  bool get _isSent => variant == MessageBubbleVariant.sent;

  @override
  Widget build(BuildContext context) {
    final avatar = CardProfil(
      imageUrl: conversation.imgUrl,
      size: 32,
      isRandom: true,
    );

    final bubble = IntrinsicWidth(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _isSent ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: _isSent ? Radius.circular(20) : Radius.circular(0),
            bottomRight: _isSent ? Radius.circular(0) : Radius.circular(20),
          ),
          border: _isSent
              ? null
              : Border.all(color: AppColors.inputBorder.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              conversation.message,
              style: TextStyle(
                fontSize: AppSizes.textSizeMedium,
                color: _isSent ? Colors.white : AppColors.textPrimary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    conversation.date,
                    style: TextStyle(
                      fontSize: AppSizes.textSizeSmall,
                      color: _isSent
                          ? Colors.white.withOpacity(0.75)
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (_isSent) ...[
                    const SizedBox(width: 4),
                    Icon(
                      conversation.isRead ? Icons.done_all : Icons.done,
                      size: 16,
                      color: conversation.isRead
                          ? Colors.white
                          : Colors.white.withOpacity(0.75),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: _isSent
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _isSent
            ? [bubble, const SizedBox(width: 8), avatar]
            : [avatar, const SizedBox(width: 8), bubble],
      ),
    );
  }
}
