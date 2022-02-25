import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenroots/constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool isHomePressed = false;
  bool isScanPressed = false;
  bool isMyPlantsPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
