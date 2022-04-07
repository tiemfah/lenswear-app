import 'package:flutter/material.dart';
import 'package:lenswear_app/model/apparel.dart';
import 'package:lenswear_app/util/theme_data.dart';
import 'package:lenswear_app/views/home_screen/apparel_list_view_item.dart';
import 'package:shimmer/shimmer.dart';

class ApparelSection extends StatelessWidget {
  final String sectionName;
  final List<Apparel> apparelList;

  const ApparelSection(
      {Key? key, required this.sectionName, required this.apparelList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            sectionName,
            style: buttonHighLightedTextStyle,
          ),
        ),
        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (Apparel a in apparelList)
                ApparelListViewItem(
                  key: Key(a.apparelID),
                  apparel: a,
                )
            ],
          ),
        )
      ],
    );
  }
}

class LoadingApparelSection extends StatelessWidget {
  final String sectionName;

  const LoadingApparelSection({Key? key, required this.sectionName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            sectionName,
            style: buttonHighLightedTextStyle,
          ),
        ),
        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                    child: Shimmer.fromColors(
                      baseColor: secondaryColor.withOpacity(0.2),
                      highlightColor: primaryColor.withOpacity(0.1),
                      child: const SizedBox(
                        width: 140,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
