import 'package:donation_flutter/services/api/services/http_request/api_request.dart';
import 'package:get_it/get_it.dart';

class GetInstance {
  static ApiRequest dataSource = GetIt.I.get<ApiRequest>();
}
