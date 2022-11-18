import 'package:dio/dio.dart';
import 'package:donation_flutter/services/api/services/http_request/api_request.dart';

class DioRequest extends ApiRequest {
  final Dio _dio = Dio();

  final Map<String, dynamic> _header = {
    "Content-Type": "application/json",
    "gini-ApiKey": "q2RKbS62lWqRUHwycQcCcE7Z1KpMDNGi"
  };

  final String _baseURL =
      "https://europe-west2-ginilab.cloudfunctions.net/app/api/";

  @override
  Future delete() {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      url = _baseURL + url;

      var response = await _dio.get(
        url,
        options: Options(headers: _header),
        queryParameters: queryParameters,
      );

      if (response.data != null) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future post(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      url = _baseURL + url;

      var response = await _dio.post(
        url,
        data: body,
        options: Options(headers: _header),
      );

      if (response.data != null) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future put() {
    throw UnimplementedError();
  }
}
