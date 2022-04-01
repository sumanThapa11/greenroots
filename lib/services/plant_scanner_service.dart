import 'dart:convert';

import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/plant_scanner_image_insert.dart';
import 'package:greenroots/models/plant_scanner_response.dart';
import 'package:greenroots/models/plant_scanner_response.dart';
import 'package:greenroots/models/plant_scanner_response.dart';
import 'package:greenroots/models/plant_scanner_response.dart';
import 'package:http/http.dart' as http;

class PlantScannerService {
  static const API = 'http://192.168.1.69:8000/api/';
  // static const API = 'http://10.0.2.2:8000/api/';
  static const headers = {
    'Content-Type': 'application/json',
    // 'Authorization':
    //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjQ3NDI4OTQ3LCJpYXQiOjE2NDc0MTkzNDcsImp0aSI6ImJjNjQxNjdkM2NhMzQwYzY4OTI4MGU0MGI0YmMyM2I2IiwidXNlcl9pZCI6Mn0.PFOcX4BBqmyC_dskArzJYrGRskfpTOwnoISm-JeQFzQ'
  };

  Future<APIResponse<PlantScannerResponse>> imageForScan(
      PlantScannerImageInsert plant) {
    return http
        .post(Uri.parse(API + 'scan_plants/'),
            headers: headers, body: json.encode(plant.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final plantDetails = PlantScannerResponse.fromJson(jsonData);
        return APIResponse<PlantScannerResponse>(data: plantDetails);
      } else if (data.statusCode == 202) {
        print(data.body);
        final jsonData = json.decode(data.body);
        final plantDetails = PlantScannerResponse.fromJson(jsonData);
        return APIResponse<PlantScannerResponse>(
            data: plantDetails, errorMessage: 'negative');
      }
      return APIResponse<PlantScannerResponse>(
          error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<PlantScannerResponse>(
            error: true, errorMessage: 'An error occurred'));
  }
}
