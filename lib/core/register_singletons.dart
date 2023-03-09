import 'package:donation_flutter/services/api/services/http_request/api_request.dart';
import 'package:donation_flutter/services/api/services/http_request/dio/dio_request.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> registerSingletons() async {
  GetIt.I.registerLazySingleton<ApiRequest>(() => DioRequest());

  try {
    final prefs = await SharedPreferences.getInstance();
    GetIt.I.registerLazySingleton<SharedPreferences>(() => prefs);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
