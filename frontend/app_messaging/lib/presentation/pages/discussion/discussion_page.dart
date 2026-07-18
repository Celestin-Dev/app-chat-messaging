import 'package:app_messaging/core/enum/appbar_variant.dart';
import 'package:app_messaging/presentation/models/conversation.dart';
import 'package:app_messaging/presentation/models/user.dart';
import 'package:app_messaging/presentation/pages/discussion/widget/card_message.dart';
import 'package:app_messaging/presentation/pages/discussion/widget/chat_input_bar.dart';
import 'package:app_messaging/presentation/services/conversation_service.dart';
import 'package:app_messaging/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_messaging/core/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:app_messaging/core/enum/message_bubble_variant.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({super.key});

  @override
  State<DiscussionPage> createState() => _DiscussionPage();
}

class _DiscussionPage extends State<DiscussionPage> {
  final User userSent = User(
    username: "Celestin",
    email: 'celestin@gmail.com',
    phone: '+261341013686',
  );
  final User userReceive = User(
    username: 'Luca',
    email: 'luca@gmail.com',
    phone: '+26134173415',
  );

  final TextEditingController messageController = TextEditingController();
  final ConversationService conversationService = ConversationService();
  final ScrollController scrollController = ScrollController();

  final List<Conversation> messages = [
    Conversation(message: "Salut toi !", date: "09:00", isRead: false),
  ];

  // Envoyer un message
  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    conversationService.sendMessage(text);

    setState(() {
      messages.add(
        Conversation(message: text, date: TimeOfDay.now().format(context)),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    messageController.clear();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  // Retour a la page precedent
  void _onBackPressed() {
    debugPrint("Back pressed");

    if (context.canPop()) {
      debugPrint("canPop = true");
      context.pop();
    } else {
      debugPrint("canPop = false");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          variant: AppBarVariant.profile,
          title: 'Discussion',
          profileImage: userReceive.photoProfil,
          username: userReceive.username,
          email: userReceive.email,
          phone: userReceive.phone,
          onBack: _onBackPressed,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.only(left: 5, right: 5),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return CardMessage(
                    conversation: messages[index],
                    variant: MessageBubbleVariant.sent,
                  );
                },
              ),
            ),

            ChatInputBar(
              controller: messageController,

              onSendPressed: sendMessage,

              onAddPressed: () {
                print("Ajouter un fichier");
              },

              onCameraTap: () {
                print("Ouvrir caméra");
              },

              onMicTap: () {
                print("Activer micro");
              },
            ),
          ],
        ),
      ),
    );
  }
}
