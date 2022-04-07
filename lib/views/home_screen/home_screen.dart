import 'package:flutter/material.dart';
import 'package:lenswear_app/model/apparel.dart';
import 'package:lenswear_app/repository/apparel.dart';
import 'package:lenswear_app/util/theme_data.dart';
import 'package:lenswear_app/views/home_screen/apparel_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> categories = ['shirt', 'pants', 'dress', 'shorts', 'skirt'];

class _HomeScreenState extends State<HomeScreen> {
  final ApparelRepository _apparelRepository = ApparelRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
              child: Text('BROWSE',
                  style: majorTextStyle.copyWith(fontWeight: FontWeight.w600)),
            ),
            for (var c in categories)
              FutureBuilder<List<Apparel>>(
                future: _apparelRepository.getApparels(
                    apparelTypeID: c, limit: 4, offset: 0),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ApparelSection(
                      sectionName: c,
                      apparelList: snapshot.data!,
                    );
                  }
                  return LoadingApparelSection(sectionName: c);
                },
              ),
          ],
        ),
      ),
    );
  }
}
