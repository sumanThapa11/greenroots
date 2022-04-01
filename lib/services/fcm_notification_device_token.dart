import 'dart:convert';

import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/user_device_token_insert.dart';
import 'package:greenroots/services/login_service.dart';
import 'package:http/http.dart' as http;

class FCMNotificationService {
  static String? token;
  static const API = 'http://10.0.2.2:8000/api/';
  static final headerAuth = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<APIResponse<bool>> registerUserDeviceToken(
      UserDeviceTokenInsert token) {
    return http
        .post(
      Uri.parse(API + 'userdevice/'),
      headers: headerAuth,
      body: jsonEncode(token.toJson()),
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
