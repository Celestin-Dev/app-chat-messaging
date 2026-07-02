import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_messaging/core/constants/colors.dart';
import 'package:app_messaging/core/constants/sizes.dart';
import 'package:app_messaging/core/enum/appbar_variant.dart';
import 'package:app_messaging/core/enum/bottom_nav_item.dart';
import 'package:app_messaging/core/widgets/app_bar.dart';
import 'package:app_messaging/core/widgets/bottom_nav.dart';
import 'package:app_messaging/core/widgets/card_message.dart';
import 'package:app_messaging/core/widgets/input_text.dart';

/// Modèle simplifié pour une conversation affichée dans la liste.
class _ConversationItem {
  final String? imageUrl;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  const _ConversationItem({
    this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });
}

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _searchController = TextEditingController();

  BottomNavItem _currentItem = BottomNavItem.messages;

  // TODO: remplacer par la vraie liste récupérée depuis le backend
  final List<_ConversationItem> _conversations = const [
    _ConversationItem(
      name: 'Jean Ricquot',
      lastMessage: 'Hello !',
      time: '14:02',
    ),
    _ConversationItem(
      name: 'Jean Ricquot',
      lastMessage: 'Hello !',
      time: '14:02',
    ),
    _ConversationItem(
      name: 'Jhon Doe',
      lastMessage: 'Bonjour',
      time: 'Hier',
      unreadCount: 2,
    ),
    _ConversationItem(
      name: 'Celestin Nomenjanahary',
      lastMessage: 'Misy fianarana rampitso !',
      time: '14:02',
      unreadCount: 2,
    ),
    _ConversationItem(
      name: 'Jean Ricquot',
      lastMessage: 'Hello !',
      time: '14:02',
    ),
    _ConversationItem(
      name: 'Jhon Doe',
      lastMessage: 'Bonjour',
      time: 'Hier',
      unreadCount: 2,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _applySystemUiStyle();
  }

  /// Couleur de la status bar (haut) et de la barre système (bas, Android)
  void _applySystemUiStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // Barre de statut (haut) : même couleur que l'AppBar
        statusBarColor: AppColors.primary,
        statusBarIconBrightness:
            Brightness.light, // icônes claires (heure, batterie...)
        statusBarBrightness: Brightness.dark, // pour iOS
        // Barre de navigation système (bas, Android) : blanche comme la bottom nav
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onDrawerPressed() {
    // TODO: ouvrir le menu latéral
  }

  void _onStartConversationPressed() {
    // TODO: naviguer vers l'écran de nouvelle conversation
  }

  void _onItemSelected(BottomNavItem item) {
    setState(() => _currentItem = item);
    // TODO: naviguer vers la page correspondante
  }

  void _onConversationTap(_ConversationItem conversation) {
    // TODO: naviguer vers l'écran de discussion
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Force le fond de l'AppBar en #1F6FEB sans toucher à CustomAppBar
      data: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          variant: AppBarVariant.home,
          title: 'Messages',
          onDrawer: _onDrawerPressed,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.defaultPadding,
                AppSizes.defaultPadding,
                AppSizes.defaultPadding,
                0,
              ),
              child: InputText(
                label: 'Recherche...',
                controller: _searchController,
                variant: InputTextVariant.search,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultPadding,
                ),
                itemCount: _conversations.length,
                itemBuilder: (context, index) {
                  final conversation = _conversations[index];
                  return InkWell(
                    onTap: () => _onConversationTap(conversation),
                    child: CardMessage(
                      imageUrl: conversation.imageUrl,
                      name: conversation.name,
                      lastMessage: conversation.lastMessage,
                      time: conversation.time,
                      unreadCount: conversation.unreadCount,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _onStartConversationPressed,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius),
          ),
          label: const Text(
            'Démarrer',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.textSizeMedium,
            ),
          ),
        ),
        // SafeArea(bottom) réserve l'espace occupé par la barre système
        // (boutons retour/home/tâches ou barre de geste) pour qu'elle ne
        // chevauche plus la bottom nav.
        bottomNavigationBar: SafeArea(
          top: false,
          child: CustomBottomNavigationBar(
            currentItem: _currentItem,
            onItemSelected: _onItemSelected,
          ),
        ),
      ),
    );
  }
}
