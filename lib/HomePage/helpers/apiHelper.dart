import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/HomePage/model/model.dart';

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  Future<List<Products?>?> fetchData() async {
    String url =
        "https://praticle-service.s3.ap-south-1.amazonaws.com/red_and_white_api.json";

    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      Map decodeData = jsonDecode(res.body);

      List allData = decodeData['ProductData'];

      List<Products?> data =
          allData.map((e) => Products.fromMap( e)).toList();

      Products products = Products.fromMap( decodeData);


      return data;
    }
    return null;
  }
}
