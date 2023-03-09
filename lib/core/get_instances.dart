import 'package:donation_flutter/services/api/services/http_request/api_request.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetInstance {
  static ApiRequest dataSource = GetIt.I.get<ApiRequest>();
  static SharedPreferences localStorage = GetIt.I.get<SharedPreferences>();
}
