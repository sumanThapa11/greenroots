import 'dart:convert';

import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/cart_item_insert.dart';
import 'package:http/http.dart' as http;

class CartService {
  static const API = 'http://10.0.2.2:8000/api/';
  static const headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjQ1ODEwMzM4LCJpYXQiOjE2NDU4MDY3MzgsImp0aSI6IjU4NjM4MDRkNWZhMDQ5ZTliZGQ0OTMzZmU0YTdiMzNjIiwidXNlcl9pZCI6NX0.Hm2D8uGhPkzOMpyQTXFxkpE62u4-L6j5R9RS2XxzAAY'
  };

  Future<APIResponse<bool>> createCart() {
    return http.post(Uri.parse(API + 'carts/'), headers: headers).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<bool>> createCartItem(CartItemInsert item) {
    return http
        .post(Uri.parse(API + 'cartItems/'),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      } else if (data.statusCode == 200) {
        return APIResponse<bool>(data: true, errorMessage: "alreadyExists");
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }
}
