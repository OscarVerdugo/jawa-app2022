class HttpResponse<T> {
  bool success;
  String message;
  T? data;
  int statusCode;
  HttpResponse(
      {required this.success,
      required this.message,
      required this.data,
      required this.statusCode});
  factory HttpResponse.fromMap(Map<String, dynamic> req, String? dataOrigin) {
    return HttpResponse(
        success: req['success'],
        message: req['message'],
        data: req[dataOrigin],
        statusCode: 200);
  }

  factory HttpResponse.fromError(String error, int statusCode) {
    return HttpResponse(
        success: false, message: error, data: null, statusCode: statusCode);
  }
}
