import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/Screens/Home/components/header_with_searchbox.dart';
import 'package:greenroots/Screens/Home/components/plant_card.dart';
import 'package:greenroots/Screens/Home/components/title_with_padding.dart';
import 'package:greenroots/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/category_list.dart';
import 'package:greenroots/models/plant_list.dart';
import 'package:greenroots/services/plants_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PlantsService get service => GetIt.I<PlantsService>();
  late APIResponse<List<CategoryList>> _apiResponseCategory;
  late APIResponse<List<PlantList>> _apiResponsePlant;

  bool _showSpinner = false;

  @override
  void initState() {
    _fetchCategoryList();
    super.initState();
  }

  _fetchCategoryList() async {
    setState(() {
      _showSpinner = true;
    });

    _apiResponseCategory = await service.getCategoryList();

    _apiResponsePlant = await service.getPlantsList();
    print(_apiResponseCategory.data![1].id);

    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final imageUrl = "http://10.0.2.2:8000";
    // final imageUrl = "http://192.168.1.69:8000";
    return SingleChildScrollView(
      child: _showSpinner
          ? kCircularProgressIndicator
          : Column(
              children: [
                HeaderWithSearchBox(size: size),
                TitleWithPadding(
                  text: "Browse by categories",
                ),
                Container(
                  height: 265,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return PlantCard(
                          image: imageUrl +
                              _apiResponseCategory.data![index].image,
                          title: _apiResponseCategory.data![index].name,
                          priceOrProduct: _apiResponseCategory
                                  .data![index].numberOfPlants
                                  .toString() +
                              "  products",
                          press: () {
                            Navigator.of(context).pushNamed('/categoryPlants',
                                arguments: _apiResponseCategory.data![index].id
                                    .toString());
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: _apiResponseCategory.data!.length),
                ),
                TitleWithPadding(text: "Recent additions"),
                Container(
                  height: 280,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return PlantCard(
                          height: 75,
                          image:
                              imageUrl + _apiResponsePlant.data![index].image,
                          title: _apiResponsePlant.data![index].name,
                          priceOrProduct: "NPR " +
                              _apiResponsePlant.data![index].unitPrice
                                  .toString(),
                          press: () {
                            Navigator.of(context).pushNamed('/plantDetails',
                                arguments: _apiResponsePlant.data![index].id
                                    .toString());
                          },
                          width: 150,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: _apiResponsePlant.data!.length),
                ),
              ],
            ),
    );
  }
}

// SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//   child: Row(
//     children: [
//       PlantCard(
//         image: "assets/images/plant1.PNG",
//         title: "Indoor plants",
//         priceOrProduct: "20",
//         press: () {},
//       ),
//       PlantCard(
//         image: "assets/images/plant1.PNG",
//         title: "Indoor plants",
//         priceOrProduct: "20",
//         press: () {},
//       ),
//       PlantCard(
//         image: "assets/images/plant1.PNG",
//         title: "Indoor plants",
//         priceOrProduct: "20",
//         press: () {},
//       ),
//     ],
//   ),
// ),
