class ResetPassword {
  String email;
  String password;
  String password2;

  ResetPassword(
      {required this.email, required this.password, required this.password2});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "password2": password2,
    };
  }
}
