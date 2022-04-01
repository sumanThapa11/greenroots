class UserDeviceTokenInsert {
  String token;

  UserDeviceTokenInsert({required this.token});

  Map<String, dynamic> toJson() {
    return {"token": token};
  }
}
