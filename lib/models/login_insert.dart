class LoginInsert {
  String email;
  String password;

  LoginInsert({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
