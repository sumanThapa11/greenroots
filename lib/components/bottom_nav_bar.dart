import 'dart:convert';
import 'dart:io' as IO;
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/plant_scanner_image_insert.dart';
import 'package:greenroots/models/plant_scanner_response.dart';
import 'package:greenroots/services/plant_scanner_service.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenroots/constants.dart';
import 'package:image_picker/image_picker.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PlantScannerService get plantScannerService => GetIt.I<PlantScannerService>();

  bool showSpinner = false;
  // _write(String text) async {
  //   final IO.Directory directory = await getApplicationDocumentsDirectory();
  //   final IO.File file = IO.File('${directory.path}/my_file1.txt');
  //   await file.writeAsString(text);
  //   print(directory);
  // }

  bool isHomePressed = false;
  bool isScanPressed = false;
  bool isMyPlantsPressed = false;

  final ImagePicker _picker = ImagePicker();
  IO.File? image;
  APIResponse<PlantScannerResponse>? _apiResponse;

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final bytes = IO.File(image.path).readAsBytesSync();
      String base64Image = "data:image/jpeg;base64," + base64Encode(bytes);
      // _write(base64Image);
      final testImage = PlantScannerImageInsert(plantImage: base64Image);
      setState(() {
        showSpinner = true;
      });
      _apiResponse = await plantScannerService.imageForScan(testImage);
      setState(() {
        showSpinner = false;
      });
      if (_apiResponse!.error != true && _apiResponse!.errorMessage == null) {
        print(_apiResponse!.data!.plantId);
        print(_apiResponse!.data!.plantName);
        int plantId = _apiResponse!.data!.plantId;
        Navigator.of(context).pushNamed(
          '/plantDetails',
          arguments: plantId.toString(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "The plant is available in our shop.",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            duration: Duration(seconds: 4),
            backgroundColor: Color(0xFF32CD32),
          ),
        );
      } else if (_apiResponse!.errorMessage == 'negative') {
        String plantName;
        plantName = _apiResponse!.data!.plantName;
        Navigator.of(context).pushNamed('/plantNotFound', arguments: plantName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(kErrorSnackBar);
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(kErrorSnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return showSpinner
        ? kCircularProgressIndicator
        : Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding * 1.5,
              right: kDefaultPadding * 1.5,
            ),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -10),
                  blurRadius: 30,
                  color: kPrimaryColor.withOpacity(0.35),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      isHomePressed = true;
                      isScanPressed = false;
                      isMyPlantsPressed = false;
                    });
                  },
                  icon: SvgPicture.asset("assets/icons/home1.svg",
                      color: isHomePressed
                          ? kPrimaryColor.withOpacity(0.8)
                          : Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isScanPressed = true;
                      isHomePressed = false;
                      isMyPlantsPressed = false;
                    });
                    pickImage();
                  },
                  icon: SvgPicture.asset("assets/icons/scan.svg",
                      color: isScanPressed
                          ? kPrimaryColor.withOpacity(0.8)
                          : Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isScanPressed = false;
                      isHomePressed = false;
                      isMyPlantsPressed = true;
                      Navigator.of(context).pushNamed('/myPlants');
                    });
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/my_plant.svg",
                    color: isMyPlantsPressed
                        ? kPrimaryColor.withOpacity(0.8)
                        : Colors.black,
                  ),
                ),
              ],
            ),
          );
  }
}
