import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenroots/components/snackBar.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/plant_scanner_response.dart';
import 'package:greenroots/services/plants_service.dart';

class HeaderWithSearchBox extends StatefulWidget {
  const HeaderWithSearchBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<HeaderWithSearchBox> createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  PlantsService get plantService => GetIt.I<PlantsService>();
  final plantNameController = TextEditingController();
  bool _showSpinner = false;

  APIResponse<PlantScannerResponse>? _apiResponse;

  @override
  void dispose() {
    plantNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _showSpinner
        ? kCircularProgressIndicator
        : Container(
            margin: EdgeInsets.only(bottom: 20 * 2.5),
            height: widget.size.height * 0.2,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30, bottom: 35),
                  height: widget.size.height * 0.2 - 27,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Our Exclusive \nplants!',
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: kPrimaryColor.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      controller: plantNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, top: 12),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: kPrimaryLightColor,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search_rounded,
                          ),
                          color: kPrimaryColor,
                          onPressed: () async {
                            String plantName = plantNameController.text;
                            setState(() {
                              _showSpinner = true;
                            });
                            _apiResponse =
                                await plantService.searchPlant(plantName);
                            setState(() {
                              _showSpinner = false;
                            });
                            if (_apiResponse!.error != true) {
                              int plantId = _apiResponse!.data!.plantId;
                              Navigator.of(context).pushNamed(
                                '/plantDetails',
                                arguments: plantId.toString(),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.buildSnackBar(
                                      "Plant not found"));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
