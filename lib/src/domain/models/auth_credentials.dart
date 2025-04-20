class AuthCredentials {
  final String email;
  final String? password;
  final String? googleToken;

  AuthCredentials({required this.email, this.password, this.googleToken});
}
