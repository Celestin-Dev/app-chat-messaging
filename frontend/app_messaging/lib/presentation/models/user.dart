class User {
  final username;
  final email;
  final photoProfil;
  final phone;

  const User({
    required this.username,
    required this.email,
    this.photoProfil = '',
    required this.phone,
  });
}
