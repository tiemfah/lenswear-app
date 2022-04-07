import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lenswear_app/model/apparel.dart';
import 'package:lenswear_app/model/prediction.dart';
import 'package:lenswear_app/util/const.dart';
import 'package:retry/retry.dart';

class ApparelRepository {
  Future<List<Apparel>> getApparels({
    required String apparelTypeID,
    required int offset,
    required int limit,
  }) async {
    final response = await http.get(Uri.parse(
        '$serviceBaseURL/api/u/apparel?limit=$limit&offset=$offset&apparelTypeID=$apparelTypeID'));
    if (response.statusCode == 200) {
      List<Apparel> res = [];
      String body = utf8.decode(response.bodyBytes);
      for (Map<String, dynamic> a in jsonDecode(body)['apparels']) {
        Apparel newApparel = Apparel.fromJson(a);
        res.add(newApparel);
      }
      return res;
    } else {
      throw Exception('Failed to getApparels: $apparelTypeID $limit $offset');
    }
  }

  Future<Apparel> getApparelByID({required String apparelID}) async {
    final response =
        await http.get(Uri.parse('$serviceBaseURL/api/u/apparel/$apparelID'));
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      Apparel res = Apparel.fromJson(jsonDecode(body));
      res.apparelID = apparelID;
      return res;
    } else {
      throw Exception('Failed to getApparelByID: $apparelID');
    }
  }

  Future<List<Apparel>> getApparelsByImage({required File image}) async {
    List<int> imageBytes = image.readAsBytesSync();
    String base64image = base64Encode(imageBytes);

    final response = await retry(
      () => http.post(Uri.parse('$modelServiceBaseURL/predict'), body: {
        'image': base64image,
      }).timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      List<Apparel> result = [];

      Prediction prediction = Prediction.fromJson(jsonDecode(response.body));
      for (var id in prediction.predictions.keys) {
        result.add(await getApparelByID(apparelID: id));
      }

      return result;
    } else {
      throw Exception('Failed to getApparelsByImage: ${response.reasonPhrase}');
    }
  }
}
