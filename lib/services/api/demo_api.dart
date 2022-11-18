import '../../models/response_model.dart';
import 'api.dart';

class DemoApi implements Api {
  Future<ResponseModel<Map<String, dynamic>>> getConnectionToken() {
    throw UnimplementedError();
  }
}
