import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/category_list.dart';
import 'package:greenroots/services/plants_service.dart';
import 'package:line_icons/line_icon.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.plantId}) : super(key: key);

  final String plantId;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PlantsService get plantService => GetIt.I<PlantsService>();

  String? errorMessage;
  late CategoryList category;

  String imageUrl = "http://10.0.2.2:8000";

  bool _showSpinner = false;

  @override
  void initState() {
    setState(() {
      _showSpinner = true;
    });

    plantService.getCategory(widget.plantId).then((response) {
      setState(() {
        _showSpinner = false;
      });
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      category = response.data!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(
      builder: (_) {
        if (_showSpinner) {
          return kCircularProgressIndicator;
        }
        if (category.plants.length == 0) {
          return Center(
            child: Text(
              "No plants available",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/plantDetails',
                      arguments: category.plants[index]['id'].toString());
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: size.width / 4.5,
                        margin: EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            imageUrl + category.plants[index]['image'],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.plants[index]['name'],
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "NPR " + category.plants[index]['unit_price'],
                                style: TextStyle(
                                    color: kSecondaryColor, fontSize: 14),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/addToCart',
                                      arguments: category.plants[index]);
                                },
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: category.plants.length);
      },
    );
  }
}
