abstract class ApiRequest {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters});
  Future put();
  Future delete();
  Future post(String url, {Map<String, dynamic>? body});
}
