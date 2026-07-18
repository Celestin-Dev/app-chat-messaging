class Conversation {
  final String imgUrl;
  final String message;
  final String date;
  final bool isRead;
  final bool isMine;

  const Conversation({
    this.imgUrl = '',
    required this.message,
    required this.date,
    this.isRead = false,
    this.isMine = false,
  });
}
