import 'package:donation_flutter/services/api/services/http_request/api_request.dart';
import 'package:donation_flutter/services/api/services/http_request/dio/dio_request.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';

Future<void> registerSingletons() async {
  GetIt.I.registerLazySingleton<ApiRequest>(() => DioRequest());
}
