import 'package:dio/dio.dart';

abstract class HttpService {
  String get baseUrl;

  Map<String, String> header(String token);

  Future<dynamic> get(
    String endpoint, {
    CancelToken? cancelToken,
  });

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  });

  Future<dynamic> put();

  Future<dynamic> delete();
}
