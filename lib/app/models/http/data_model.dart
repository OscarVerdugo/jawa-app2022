import 'package:jawa_app/app/models/http/res_model.dart';
import 'dart:convert';

class Data<T> {
  final HttpResponse<T> response;
  T? data;
  Data({required this.response, required this.data});
}

class Pagination {
  Pagination({
    required this.page,
    required this.pages,
    required this.take,
    required this.total,
    required this.search,
    required this.firstRowOnPage,
    required this.lastRowOnPage,
  });

  int page;
  final int pages;
  final int take;
  final int total;
  String? search;
  final int firstRowOnPage;
  final int lastRowOnPage;

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.init() {
    return Pagination(
        page: 1,
        pages: 0,
        take: 15,
        total: 0,
        search: null,
        firstRowOnPage: 0,
        lastRowOnPage: 0);
  }

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pages: json["pages"],
        take: json["take"],
        total: json["total"],
        search: json["search"],
        firstRowOnPage: json["firstRowOnPage"],
        lastRowOnPage: json["lastRowOnPage"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "pages": pages,
        "take": take,
        "total": total,
        "search": search,
        "firstRowOnPage": firstRowOnPage,
        "lastRowOnPage": lastRowOnPage,
      };
}
