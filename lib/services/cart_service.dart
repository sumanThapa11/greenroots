import 'dart:convert';

import 'package:greenroots/constants.dart';
import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/cart_item_insert.dart';
import 'package:greenroots/models/order_insert.dart';
import 'package:greenroots/models/plant_order_insert.dart';
import 'package:greenroots/models/users_cart_items.dart';
import 'package:greenroots/services/fcm_notification_device_token.dart';
import 'package:greenroots/services/login_service.dart';
import 'package:http/http.dart' as http;

class CartService {
  // static const API = 'http://10.0.2.2:8000/api/';
  static String? token = FCMNotificationService.token;

  static final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
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

  Future<APIResponse<UsersCartItem>> getUsersCartItems() {
    return http
        .get(Uri.parse(API + 'user/cart/'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        return APIResponse<UsersCartItem>(
            data: UsersCartItem.fromJson(jsonData), errorMessage: '');
      } else if (data.statusCode == 202) {
        return APIResponse<UsersCartItem>(
            data: UsersCartItem(total: 0.00, cartItems: []),
            errorMessage: 'emptyCart');
      } else if (data.statusCode == 404) {
        return APIResponse<UsersCartItem>(
            data: UsersCartItem(total: 0.00, cartItems: []),
            errorMessage: 'emptyCart');
      }
      return APIResponse<UsersCartItem>(
          error: true, errorMessage: 'An error occurred');
    }).catchError(
      (_) => APIResponse<UsersCartItem>(
          error: true, errorMessage: 'An error occurred'),
    );
  }

  Future<APIResponse<bool>> deleteCartItem(String cartId) {
    return http
        .delete(
      Uri.parse(API + 'cartItems/' + cartId + '/'),
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

  // currently logged in user
  Future<APIResponse<bool>> deleteCart() {
    return http
        .delete(
      Uri.parse(API + 'user/cart/'),
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<OrderInsert>> createOrder(OrderInsert order) {
    return http
        .post(Uri.parse(API + 'orders/'),
            headers: headers, body: json.encode(order.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        final jsonData = json.decode(data.body);
        final OrderInsert orderInsert = OrderInsert.fromJson(jsonData);
        return APIResponse<OrderInsert>(data: orderInsert);
      }
      return APIResponse<OrderInsert>(
          error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<OrderInsert>(
            error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<bool>> createPlantOrder(PlantOrderInsert plantOrder) {
    return http
        .post(Uri.parse(API + 'plantOrder/'),
            headers: headers, body: json.encode(plantOrder.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        final jsonData = json.decode(data.body);

        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }
}
