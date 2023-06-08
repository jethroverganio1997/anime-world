import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/configs.dart';
import 'dio_error_interceptor.dart';
import 'dio_time_interceptor.dart';
import 'http_service.dart';
import 'dio_logs_interceptor.dart';

final apiServiceProvider = Provider.autoDispose<ApiService>((ref) {
  return ApiService(Configs.API_BASE_URL);
});

class ApiService implements HttpService {
  ApiService(
    this.baseUrl, {
    Dio? dioOverride,
  }) {
    dio = dioOverride ?? Dio(baseOptions);
    dio.interceptors.add(DioLogsInterceptor());
    dio.interceptors.add(DioErrorInterceptor());
    dio.interceptors.add(DioTimeInterceptor());
  }

  late final Dio dio;

  @override
  final String baseUrl;

  @override
  Map<String, String> header(String token) =>
      {'Authorization': 'Bearer $token', 'Content-type': 'application/x-www-form-urlencoded'};

  BaseOptions get baseOptions => BaseOptions(
        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 5),
        sendTimeout: const Duration(minutes: 5),
        baseUrl: baseUrl,
        // headers: header(token),
      );

  @override
  Future<dynamic> get(String endpoint, {CancelToken? cancelToken, Map<String, dynamic>? body}) async {
    try {
      final Response response = await dio.get(endpoint, queryParameters: body, cancelToken: cancelToken);
      return response.data;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body, CancelToken? cancelToken}) async {
    try {
      final Response response = await dio.post(
        endpoint,
        cancelToken: cancelToken,
        data: body,
        // queryParameters: body,
      );
      return response.data;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future delete() {
    throw UnimplementedError();
  }

  @override
  Future put() {
    throw UnimplementedError();
  }
}
