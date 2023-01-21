// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<List> getData({required String token}) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/list-Product');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      print(response.statusCode);
      var decodedResponse = jsonDecode(response.body);
      return decodedResponse['data'];
    }
    return [];
  }

  static Future<bool> getLike({required String token, required int id}) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/like-Product/$id');
    var response =
        await http.post(url, headers: {"Authorization": "Bearer $token"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['message'] == " Like successfully removed") {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  static Future<bool> deleteProduct(
      {required String token, required int id}) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/delete-Product/$id');
    var response =
        await http.delete(url, headers: {"Authorization": "Bearer $token"});

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
    }
    return false;
  }

  static Future<int> addData(
      {required String token,
      required String filename,
      required String name,
      required String data,
      required File photo,
      required String quantity,
      required String price,
      required String number}) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/create-Product');
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://10.0.2.2:8000/api/create-Product"),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    request.files.add(
      http.MultipartFile(
        "photo",
        photo.readAsBytes().asStream(),
        photo.lengthSync(),
        filename: filename,
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "name": name,
      "expiry_date": data,
      "quantity": quantity,
      "price": price,
      "social": number
    });
    print("request: " + request.toString());
    var res = await request.send();
    print("This is response:" + res.toString());
    print(res.statusCode);
    return res.statusCode;
  }

  static Future<List> getSearchName(
      {required String name, required String token}) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/search-Product-name/$name');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    print(response.body);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return decodedResponse['data'];
    }
    return [];
  }

  static Future<List> getSearchExpiryEnd(
      {required String expiryEnd, required String token}) async {
    Uri url =
        Uri.parse('http://10.0.2.2:8000/api/search-Product-exp/$expiryEnd');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    print(response.statusCode);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      print(decodedResponse['success']);
      if (decodedResponse['success'] == false) return [];
      return decodedResponse['data'];
    }
    return [];
  }

  static Future<void> addView(
      {required int productId, required String token}) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/single-Product/$productId');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    print(response.body);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
    }
  }

  static Future<void> getLikeOnProduct(
      {required int productId, required String token}) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/single-Product/$productId');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    print(response.body);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
    }
  }
}
