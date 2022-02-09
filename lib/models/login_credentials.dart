class LoginCredentials {
  String token;
  String refreshToken;

  LoginCredentials({
    required this.token,
    required this.refreshToken,
  });

  factory LoginCredentials.fromJson(Map<String, dynamic> jsonData) {
    return LoginCredentials(
      token: jsonData['access'],
      refreshToken: jsonData['refresh'],
    );
  }
}
