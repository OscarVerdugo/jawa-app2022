class HttpResponse<T> {
  bool success;
  String message;
  T? data;
  dynamic rawData;
  int statusCode;
  HttpResponse(
      {required this.success,
      required this.message,
      this.data,
      required this.rawData,
      required this.statusCode});
  factory HttpResponse.fromMap(Map<String, dynamic> req, String? dataOrigin) {
    return HttpResponse(
        success: req['success'],
        message: req['message'],
        rawData: dataOrigin == null ? null : req[dataOrigin],
        statusCode: 200);
  }

  factory HttpResponse.fromError(String error, int statusCode) {
    return HttpResponse(
        success: false, message: error, rawData: null, statusCode: statusCode);
  }
}
