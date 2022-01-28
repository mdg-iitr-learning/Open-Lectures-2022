// dart imports
import 'dart:convert';

// package imports
import 'package:http/http.dart';

// app imports
import 'package:app/model/data_model.dart';

class ApiService {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'https://corona.lmao.ninja/v2';

  Future<List<DataModel>> getData() async {
    Uri uri = Uri.parse('$BASE_URL/countries?yesterday&sort');
    Response response = await get(uri);

    if (response.statusCode == 200) {
      List<dynamic> parsedJson = jsonDecode(response.body);
      List<DataModel> data =
          parsedJson.map((json) => DataModel.fromJson(json)).toList();
      return data;
    } else {
      throw 'Error while fetching data';
    }
  }
}
