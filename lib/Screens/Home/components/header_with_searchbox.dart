import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenroots/constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20 * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 30, bottom: 35),
            height: size.height * 0.2 - 27,
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
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15, top: 12),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: kPrimaryLightColor,
                  suffixIcon: Icon(
                    Icons.search_rounded,
                    color: kPrimaryColor,
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
