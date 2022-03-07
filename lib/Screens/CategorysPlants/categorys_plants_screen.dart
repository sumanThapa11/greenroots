import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/components/rounded_back_button.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/category_list.dart';
import 'package:greenroots/services/plants_service.dart';
import 'package:line_icons/line_icons.dart';

import 'components/body.dart';

class CategoryPlants extends StatefulWidget {
  const CategoryPlants({Key? key, required this.plantId}) : super(key: key);

  final String plantId;

  @override
  State<CategoryPlants> createState() => _CategoryPlantsState();
}

class _CategoryPlantsState extends State<CategoryPlants> {
  PlantsService get plantService => GetIt.I<PlantsService>();

  String? errorMessage;
  late CategoryList category;

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
    return _showSpinner
        ? kCircularProgressIndicator
        : Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryLightColor,
              leading: RoundedBackButton(
                color: kPrimaryLightColor,
              ),
              title: Center(
                child: Text(
                  category.name,
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/cart');
                  },
                  icon: Icon(
                    LineIcons.shoppingCart,
                    color: kPrimaryColor,
                    size: 32,
                  ),
                ),
              ],
            ),
            body: Body(
              plantId: (widget.plantId),
            ),
          );
  }
}
