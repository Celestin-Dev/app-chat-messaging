class ConversationService {
  void sendMessage(String message) {
    final text = message.trim();

    if (text.isEmpty) return;

    print("Message envoyé : $text");

    // TODO:
    // envoyer API
  }
}
