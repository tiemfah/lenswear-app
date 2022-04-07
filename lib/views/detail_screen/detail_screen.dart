import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenswear_app/model/apparel.dart';
import 'package:lenswear_app/util/const.dart';
import 'package:lenswear_app/util/theme_data.dart';

class ApparelDetailScreen extends StatelessWidget {
  final Apparel apparel;

  const ApparelDetailScreen({Key? key, required this.apparel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgUrl =
        '$imageStorageBaseURL/lenswear-service-${apparel.apparelTypeID}/${apparel.apparelID}/0.jpg';
    const imageHeight = 460.0;
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
            child: DetailScreenCurve(
              borderHeight: borderHeight,
              screenWidth: screenWidth,
            ),
          ),
          Positioned(
            top: imageHeight,
            height: screenHeight - imageHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: ApparelInfo(apparel: apparel),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreenCurve extends StatelessWidget {
  final double borderHeight;
  final double screenWidth;

  const DetailScreenCurve(
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

class ApparelInfo extends StatelessWidget {
  final Apparel apparel;

  const ApparelInfo({Key? key, required this.apparel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width - 32;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BRAND: ${apparel.brand}",
                  style:
                      minorHighLightedTextStyle.copyWith(color: secondaryColor),
                ),
                for (var w in apparel.name.split(" "))
                  Text(w, style: majorTextStyle),
              ],
            ),
            Text(
              "${apparel.price} THB",
              style: majorTextStyle.copyWith(color: redColor),
            ),
            ApparelStoreButton(storeURL: apparel.storeURL),
          ],
        ),
      ),
    );
  }
}

class ApparelStoreButton extends StatelessWidget {
  final String storeURL;
  const ApparelStoreButton({Key? key, required this.storeURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        width: 325,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            color: secondaryColor.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(storeURL.substring(0, 28)),
                  GestureDetector(
                    child: const Icon(Icons.copy),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: storeURL))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("URL copied to clipboard!")));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
