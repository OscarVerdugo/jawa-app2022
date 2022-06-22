import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;
import 'package:jawa_app/app/models/http/data_model.dart';
import 'dart:convert';

import '../models/http/res_model.dart';

class HttpService {
  static final client = http.Client();
  static final String url = "http://18.224.14.238:2022/api/";
  static final storage = FlutterSecureStorage();

  static Future<HttpResponse<T>> get<T>(
      {required String method, String? dataOrigin}) async {
    try {
      final token = await storage.read(key: "access-token");

      final response = await client.get(Uri.parse("$url$method"), headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json"
      });
      if (response.statusCode == 200) {
        HttpResponse<T> result =
            HttpResponse.fromMap(json.decode(response.body), dataOrigin);
        return result;
      } else {
        final error = json.decode(response.body);
        HttpResponse<T> result =
            HttpResponse.fromError(error['message'], response.statusCode);
        return result;
      }
    } catch (e) {
      HttpResponse<T> result = HttpResponse.fromError("Error: $e", 000);
      return result;
    }
  }

  static Future<HttpResponse<T>> post<T>(
      {required String method,
      Map<String, dynamic>? data,
      String? dataOrigin}) async {
    try {
      final token = await storage.read(key: "access-token");

      final response = await client.post(Uri.parse("$url$method"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode(data));
      if (response.statusCode == 200) {
        HttpResponse<T> result =
            HttpResponse.fromMap(json.decode(response.body), dataOrigin);
        return result;
      } else {
        final error = json.decode(response.body);
        HttpResponse<T> result =
            HttpResponse.fromError(error['message'], response.statusCode);
        return result;
      }
    } catch (e) {
      HttpResponse<T> result = HttpResponse.fromError("Error: $e", 000);
      return result;
    }
  }

  static Future<HttpResponsePagination<T>> postPagination<T>(
      {required String method,
      required Map<String, dynamic> data,
      required Pagination pagination,
      String? dataOrigin}) async {
    try {
      final token = await storage.read(key: "access-token");
      data.addAll(pagination.toMap());

      final response = await client.post(Uri.parse("$url$method"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode(data));

      if (response.statusCode == 200) {
        HttpResponsePagination<T> result = HttpResponsePagination.fromMap(
            json.decode(response.body), dataOrigin);
        return result;
      } else {
        final error = json.decode(response.body);
        HttpResponsePagination<T> result = HttpResponsePagination.fromError(
            error['message'], response.statusCode);
        return result;
      }
    } catch (e) {
      HttpResponsePagination<T> result =
          HttpResponsePagination.fromError("Error: $e", 000);
      return result;
    }
  }
}
