import 'package:flutter/material.dart';
import 'package:lenswear_app/model/apparel.dart';
import 'package:lenswear_app/util/const.dart';
import 'package:lenswear_app/util/theme_data.dart';
import 'package:lenswear_app/views/home_screen/apparel_section.dart';

class SearchResultScreen extends StatelessWidget {
  final List<Apparel> results;
  const SearchResultScreen({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgUrl =
        '$imageStorageBaseURL/lenswear-service-${results[0].apparelTypeID}/${results[0].apparelID}/0.jpg';
    const imageHeight = 520.0;
    const borderHeight = 40.0;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primaryColor,
      appBar: AppBar(
        foregroundColor: accentColor,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            height: imageHeight,
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              height: imageHeight,
              width: screenWidth,
            ),
          ),
          Positioned(
            top: imageHeight - borderHeight,
            height: borderHeight,
            child: SearchResultScreenCurve(
              borderHeight: borderHeight,
              screenWidth: screenWidth,
            ),
          ),
          Positioned(
            top: imageHeight,
            height: screenHeight - imageHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: SearchResultScreenAlternative(
                results: results,
                screenWidth: screenWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultScreenCurve extends StatelessWidget {
  final double borderHeight;
  final double screenWidth;

  const SearchResultScreenCurve(
      {Key? key, required this.borderHeight, required this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: borderHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: navBarShadow,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
    );
  }
}

class SearchResultScreenAlternative extends StatelessWidget {
  final List<Apparel> results;
  final double screenWidth;
  const SearchResultScreenAlternative(
      {Key? key, required this.results, required this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: 100,
        width: screenWidth,
        child: ApparelSection(
          sectionName: "Search Result",
          apparelList: results,
        ),
      ),
    );
  }
}
