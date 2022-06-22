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

class HttpResponsePagination<T> {
  bool success;
  String message;
  T? data;
  int page;
  int pages;
  int take;
  int total;
  String? search;
  int firstRowOnPage;
  int lastRowOnPage;
  dynamic rawData;
  int statusCode;

  HttpResponsePagination(
      {required this.success,
      required this.message,
      this.data,
      required this.rawData,
      required this.statusCode,
      required this.page,
      required this.pages,
      required this.take,
      required this.total,
      required this.search,
      required this.firstRowOnPage,
      required this.lastRowOnPage});
  factory HttpResponsePagination.fromMap(
      Map<String, dynamic> req, String? dataOrigin) {
    return HttpResponsePagination(
        success: req['success'],
        message: req['message'],
        rawData: dataOrigin == null ? null : req['data'][dataOrigin],
        page: req['data']['page'] ?? 0,
        pages: req['data']['pages'] ?? 0,
        take: req['data']['take'] ?? 0,
        total: req['data']['total'] ?? 0,
        search: req['data']['search'],
        firstRowOnPage: req['data']['firstRowOnPage'] ?? 0,
        lastRowOnPage: req['data']['lastRowOnPage'] ?? 0,
        statusCode: 200);
  }

  factory HttpResponsePagination.fromError(String error, int statusCode) {
    return HttpResponsePagination(
        success: false,
        message: error,
        rawData: null,
        statusCode: statusCode,
        page: 0,
        pages: 0,
        firstRowOnPage: 0,
        lastRowOnPage: 0,
        take: 0,
        total: 0,
        search: null);
  }
}
