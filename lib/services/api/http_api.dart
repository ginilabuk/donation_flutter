import 'dart:developer';

import 'package:dio/dio.dart';

import '../../models/response_model.dart';
import 'api.dart';

class HttpApi implements Api {
  // static String _baseURL = "http://localhost/tomafood-net/api/v2";
  // static String _baseURL = "https://api.tomafood.co.uk/v2"; // Test Server
  // static String _baseURL = "http://10.0.2.2/tomafood-net/api/v2";
  final String _baseURL = "https://api.tomafood.net/v2"; // Live server

  final Map<String, dynamic> _header = {
    "Content-Type": "application/json",
    "gini-ApiKey": "q2RKbS62lWqRUHwycQcCcE7Z1KpMDNGi"
  };

  static Future<Map<String, dynamic>?> _httpRequest({
    required String url,
    required Map<String, dynamic> header,
    dynamic body,
    required String method,
  }) async {
    try {
      var dio = Dio();
      // await Future.delayed(Duration(seconds: 1));
      log("API Called 💣💣💣 : $url");
      ////print("API Called 💣💣💣 : ${jsonEncode(body)}");

      switch (method) {
        case "put":
          return await dio
              .put(url, data: body, options: Options(headers: header))
              .then((value) => value.data);

        case "delete":
          return await dio
              .delete(url, data: body, options: Options(headers: header))
              .then((value) => value.data);

        case "post":
          return await dio
              .post(url, data: body, options: Options(headers: header))
              .then((value) => value.data);

        default:
          return await dio
              .get(url, options: Options(headers: header))
              .then((value) => value.data);
      }
    } catch (e) {
      if (e is DioError) {
        return e.response?.data;
      }
    }
    return null;
  }

  // Get recipe category and subcategory
  @override
  Future<ResponseModel<Map<String, dynamic>>> getConnectionToken() async {
    try {
      String url = "$_baseURL/api/v1/stripe/terminal/connection_token";
      var response =
          await _httpRequest(url: url, header: _header, method: "post");

      print(response);
      return ResponseModel(status: true, data: response);
    } catch (e) {
      return ResponseModel(status: false, errors: [e.toString()]);
    }
  }
}
