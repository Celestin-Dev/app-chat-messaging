class Contact {
  final String imgUrl;
  final String name;
  final String email;
  final String phoneNumber;

  const Contact({
    this.imgUrl = '',
    required this.name,
    required this.email,
    this.phoneNumber = '',
  });
}
