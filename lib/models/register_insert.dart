class RegisterInsert {
  String email;
  String firstName;
  String lastName;
  String address;
  String phone;
  String password;
  String confirmPassword;

  RegisterInsert(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.address,
      required this.phone,
      required this.password,
      required this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "address": address,
      "phone": phone,
      "password": password,
      "password2": confirmPassword
    };
  }
}
