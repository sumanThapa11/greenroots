import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/login_credentials.dart';
import 'package:greenroots/models/login_insert.dart';
import 'package:greenroots/models/register_insert.dart';
import 'package:greenroots/models/user_device_token_insert.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static final storage = FlutterSecureStorage();
  static const API = 'http://10.0.2.2:8000/api/';
  static const headers = {'Content-Type': 'application/json'};

  static Future<String?> getToken() async {
    String? data = await storage.read(key: "token");
    print(data);
    return data;
  }

  Future<APIResponse<LoginCredentials>> loginUser(LoginInsert loginData) {
    return http
        .post(
      Uri.parse(API + 'token/'),
      headers: headers,
      body: json.encode(
        loginData.toJson(),
      ),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final loginCredentials = LoginCredentials.fromJson(jsonData);
        return APIResponse<LoginCredentials>(data: loginCredentials);
      } else if (data.statusCode == 401) {
        return APIResponse<LoginCredentials>(
            error: true, errorMessage: 'unauthorized');
      }
      return APIResponse<LoginCredentials>(
        error: true,
        errorMessage: "An error occurred",
      );
    }).catchError(
      (_) => APIResponse<LoginCredentials>(
        error: true,
        errorMessage: "An error occurred",
      ),
    );
  }

  Future<APIResponse<bool>> registerUser(RegisterInsert user) {
    return http
        .post(
      Uri.parse(API + 'register/'),
      headers: headers,
      body: jsonEncode(user.toJson()),
    )
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<String>> sendEmailToken(String email) {
    Map<String, String> emailData = {"email": email};
    return http
        .post(
      Uri.parse(API + 'sendtoken/'),
      headers: headers,
      body: jsonEncode(emailData),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final otp = jsonData['otp'];
        return APIResponse<String>(data: otp);
      }
      return APIResponse<String>(
          error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<String>(
            error: true, errorMessage: 'An error occurred'));
  }
}
