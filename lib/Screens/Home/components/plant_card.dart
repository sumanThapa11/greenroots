import 'package:flutter/material.dart';
import 'package:greenroots/constants.dart';

class PlantCard extends StatelessWidget {
  const PlantCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.priceOrProduct,
      required this.press,
      this.width,
      this.height})
      : super(key: key);

  final String image, title, priceOrProduct;
  final double? width, height;

  final Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding / 1.5,
        top: kDefaultPadding / 1.5,
        bottom: kDefaultPadding,
      ),
      width: size.width * 0.4,
      child: Column(
        children: [
          Container(
            width: width != null ? width : size.width / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                image,
                height: 170,
                fit: BoxFit.fill,
              ),
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              height: height != null
                  ? height
                  : size.height / 8.6, //14.5 in big phone
              padding: EdgeInsets.all(kDefaultPadding / 3),
              width: width != null ? width : size.width / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 30,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "$priceOrProduct",
                    style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.9),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
