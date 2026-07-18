import 'package:app_messaging/core/constants/colors.dart';
import 'package:app_messaging/core/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:app_messaging/core/enum/appbar_variant.dart';
import 'package:app_messaging/presentation/widgets/card_profil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarVariant variant;

  final String title;

  final String? profileImage;

  final String? username;

  final String? email;

  final String? phone;

  final VoidCallback? onBack;

  final VoidCallback? onMenu;

  final VoidCallback? onDrawer;

  final VoidCallback? onEdit;

  const CustomAppBar({
    super.key,
    required this.variant,
    required this.title,
    this.profileImage,
    this.username,
    this.email,
    this.phone,
    this.onBack,
    this.onMenu,
    this.onDrawer,
    this.onEdit,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AppBarVariant.home:
        return _buildHome();

      case AppBarVariant.profile:
        return _buildProfile();

      case AppBarVariant.messages:
        return _buildMessages();

      case AppBarVariant.simpleBack:
        return _buildSimpleBack();
    }
  }

  // Build the home variant of the app bar
  Widget _buildHome() {
    return AppBar(
      toolbarHeight: 56,

      leading: IconButton(icon: const Icon(Icons.menu), onPressed: onDrawer),

      title: Text(title),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CardProfil(imageUrl: profileImage, size: 40),
        ),
      ],
    );
  }

  // Build the profile variant of the app bar
  Widget _buildProfile() {
    return AppBar(
      toolbarHeight: 56,

      leading: BackButton(onPressed: onBack),

      title: Row(
        children: [
          CardProfil(imageUrl: profileImage, size: 42, isRandom: false),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  username ?? "",
                  style: TextStyle(
                    fontSize: AppSizes.textSizeMedium,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(email ?? "", style: const TextStyle(fontSize: 10)),

                Text(phone ?? "", style: const TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),

      actions: [
        IconButton(
          onPressed: onMenu,
          icon: const Icon(Icons.more_vert, color: AppColors.backgroundColor),
        ),
      ],
    );
  }

  // Build the messages variant of the app bar
  Widget _buildMessages() {
    return AppBar(
      leading: BackButton(onPressed: onBack),

      title: Text(title),

      actions: [
        IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined)),
      ],
    );
  }

  // Build the simple back variant of the app bar
  Widget _buildSimpleBack() {
    return AppBar(
      leading: BackButton(onPressed: onBack),

      title: Text(title),
    );
  }
}
