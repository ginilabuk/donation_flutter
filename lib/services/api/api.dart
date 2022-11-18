import '../../models/response_model.dart';

abstract class Api {
  Future<ResponseModel<Map<String, dynamic>>> getConnectionToken();
}
