import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/components/text_field_container.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/services/plants_service.dart';
import 'package:line_icons/line_icons.dart';
import 'package:greenroots/models/plant_list.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.plantId}) : super(key: key);

  final String plantId;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PlantsService get plantService => GetIt.I<PlantsService>();

  String? errorMessage;
  late PlantList plant;
  Map<String, dynamic> plantForCart = {};

  bool _showSpinner = false;

  String imageUrl = "http://10.0.2.2:8000";

  @override
  void initState() {
    super.initState();
    setState(() {
      _showSpinner = true;
    });
    plantService.getPlant(widget.plantId).then((response) {
      setState(() {
        _showSpinner = false;
      });
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      plant = response.data!;
      plantForCart = plant.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _showSpinner
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kPrimaryLightColor,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height / 2.5,
                    child: Image.network(
                      imageUrl + plant.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/icons/line_rounded_edges.svg",
                        color: Colors.grey,
                      ),
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  plant.name,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "NPR " + plant.unitPrice,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      right: 30,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    // height: size.width / 13,
                    width: size.width / 4.8,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      plant.suitableTemperature,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Description",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  plant.description,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                height: size.width / 9,
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Image.asset(
                    "assets/icons/add-cart.png",
                    color: Colors.white,
                    height: 24,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/addToCart', arguments: plantForCart);
                  },
                  label: Text(
                    "Add to cart",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
