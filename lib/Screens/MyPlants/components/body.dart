import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/Screens/ErrorScreen/connection_failed.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/plant_list.dart';
import 'package:greenroots/services/plants_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PlantsService get service => GetIt.I<PlantsService>();

  late APIResponse<List<PlantList>> _apiResponse;
  bool _showSpinner = false;

  // String imageUrl = "http://10.0.2.2:8000";
  // String imageUrl = "http://192.168.1.69:8000";

  @override
  void initState() {
    _fetchUserPlants();
    super.initState();
  }

  _fetchUserPlants() async {
    setState(() {
      _showSpinner = true;
    });

    _apiResponse = await service.getMyPlants();

    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(
      builder: (_) {
        if (_showSpinner) {
          return kCircularProgressIndicator;
        }
        if (_apiResponse.data == null) {
          return ConnectionFailedScreen();
        }
        if (_apiResponse.data!.length == 0) {
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
                      arguments: _apiResponse.data![index].id.toString());
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
                            kImageUrl + _apiResponse.data![index].image,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _apiResponse.data![index].name,
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Suitable at " +
                                    _apiResponse
                                        .data![index].suitableTemperature,
                                style: TextStyle(
                                    color: kSecondaryColor, fontSize: 14),
                              ),
                              SizedBox(
                                width: 60,
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
            itemCount: _apiResponse.data!.length);
      },
    );
  }
}
