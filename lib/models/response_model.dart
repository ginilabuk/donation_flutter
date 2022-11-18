class ResponseModel<T> {
  bool status;
  List<String> errors;
  String? message;
  int? count;
  T? data;

  ResponseModel({
    this.status = false,
    this.message,
    this.data,
    this.count,
    List<String>? errors,
  }) : errors = errors ?? ["Something went wrong"];

  T? getData() => status == true ? data : null;

  String get getMessage =>
      status == true ? message ?? "Success" : message ?? "Something went wrong";
}
