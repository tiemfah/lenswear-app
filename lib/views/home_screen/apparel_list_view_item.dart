import 'package:flutter/material.dart';
import 'package:lenswear_app/model/apparel.dart';
import 'package:lenswear_app/util/const.dart';
import 'package:lenswear_app/views/detail_screen/detail_screen.dart';

class ApparelListViewItem extends StatelessWidget {
  final Apparel apparel;

  const ApparelListViewItem({Key? key, required this.apparel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgUrl =
        '$imageStorageBaseURL/lenswear-service-${apparel.apparelTypeID}/${apparel.apparelID}/0.jpg';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ApparelDetailScreen(apparel: apparel))),
          child: SizedBox(
            width: 140,
            child: FittedBox(
              child: Image.network(imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
