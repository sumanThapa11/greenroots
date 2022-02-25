import 'dart:convert';

import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/login_credentials.dart';
import 'package:greenroots/models/login_insert.dart';
import 'package:greenroots/models/register_insert.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static const API = 'http://10.0.2.2:8000/api/';
  static const headers = {'Content-Type': 'application/json'};

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
}
