import 'package:flutter/material.dart';
import 'package:greenroots/components/rounded_back_button.dart';
import 'package:greenroots/constants.dart';
import 'package:line_icons/line_icons.dart';

import 'components/body.dart';

class PlantDetailsScreen extends StatelessWidget {
  const PlantDetailsScreen({Key? key, required this.plantId}) : super(key: key);

  final String plantId;

  @override
  Widget build(BuildContext context) {
    print(plantId);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        leading: RoundedBackButton(
          color: kPrimaryLightColor,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              LineIcons.shoppingCart,
              color: kPrimaryColor,
              size: 32,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height - 100,
          child: Body(
            plantId: plantId,
          ),
        ),
      ),
    );
  }
}
