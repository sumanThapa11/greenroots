import 'dart:convert';

import 'package:greenroots/Screens/PlantDetails/components/body.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/category_list.dart';
import 'package:greenroots/models/plant_list.dart';
import 'package:greenroots/models/users_plant_insert.dart';
import 'package:greenroots/services/fcm_notification_device_token.dart';
import 'package:http/http.dart' as http;

class PlantsService {
  // static const API = 'http://192.168.1.69:8000/api/';
  // static const API = 'http://10.0.2.2:8000/api/';
  static String? token = FCMNotificationService.token;
  static final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  Future<APIResponse<List<CategoryList>>> getCategoryList() {
    return http
        .get(
      Uri.parse(API + 'category/'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final categories = <CategoryList>[];
        for (var item in jsonData) {
          final category = CategoryList.fromJson(item);
          categories.add(category);
        }
        return APIResponse<List<CategoryList>>(data: categories);
      }
      return APIResponse<List<CategoryList>>(
          error: true, errorMessage: 'An error occurred');
    }).catchError(
      (_) => APIResponse<List<CategoryList>>(
          error: true, errorMessage: 'An error occurred'),
    );
  }

  Future<APIResponse<CategoryList>> getCategory(String id) {
    return http
        .get(
      Uri.parse(API + 'category/' + id),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<CategoryList>(data: CategoryList.fromJson(jsonData));
      }
      return APIResponse<CategoryList>(
          error: true, errorMessage: 'An error occurred');
    }).catchError(
      (_) => APIResponse<CategoryList>(
          error: true, errorMessage: 'An error occurred'),
    );
  }

  Future<APIResponse<List<PlantList>>> getPlantsList() {
    return http
        .get(
      Uri.parse(API + 'plants/'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final plants = <PlantList>[];
        for (var item in jsonData) {
          final plant = PlantList.fromJson(item);
          plants.add(plant);
        }
        return APIResponse<List<PlantList>>(data: plants);
      }
      return APIResponse<List<PlantList>>(
          error: true, errorMessage: 'An error occurred');
    }).catchError(
      (_) => APIResponse<List<PlantList>>(
          error: true, errorMessage: 'An error occurred'),
    );
  }

  Future<APIResponse<PlantList>> getPlant(String id) {
    return http
        .get(
      Uri.parse(API + 'plants/' + id),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<PlantList>(data: PlantList.fromJson(jsonData));
      }
      return APIResponse<PlantList>(
          error: true, errorMessage: 'An error occurred');
    }).catchError(
      (_) => APIResponse<PlantList>(
          error: true, errorMessage: 'An error occurred'),
    );
  }

  Future<APIResponse<List<PlantList>>> getMyPlants() {
    return http
        .get(Uri.parse(API + 'user/plant_details/'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final plants = <PlantList>[];
        for (var item in jsonData) {
          final plant = PlantList.fromJson(item);
          plants.add(plant);
        }
        return APIResponse<List<PlantList>>(data: plants);
      }
      return APIResponse<List<PlantList>>(
          error: true, errorMessage: 'An error occurred');
    }).catchError(
      (_) => APIResponse<List<PlantList>>(
          error: true, errorMessage: 'An error occurred'),
    );
  }

  Future<APIResponse<bool>> createUsersPlant(UsersPlantInsert plant) {
    return http
        .post(Uri.parse(API + 'user/plants/'),
            headers: headers, body: json.encode(plant.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<double>> getTemperature(
      double latitude, double longitude) {
    return http
        .get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$weatherApiKey&units=metric'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        double temperature = jsonData['main']['temp'];
        return APIResponse<double>(data: temperature);
      }
      return APIResponse<double>(
          error: true, errorMessage: 'An error occurred');
    }).catchError(
      (_) =>
          APIResponse<double>(error: true, errorMessage: 'An error occurred'),
    );
  }
}
