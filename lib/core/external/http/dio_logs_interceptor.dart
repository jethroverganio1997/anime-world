import 'dart:convert';
import 'package:dio/dio.dart';

import '../../common_widgets/custom_logger.dart';

enum DioLogs { onResponse, onError, onRequest }

class DioLogsInterceptor extends Interceptor {
  final log = getLogger('HttpLoggger');

  final JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.e('[DIO][ERROR]<-- ${err.response?.statusCode} ${err.response?.statusMessage ?? ''}');
    log.e('[DIO][URL] ${err.requestOptions.uri}');

    final data = err.response?.data;
    if (data != null) {
      if (data is Map) {
        logJson(data, DioLogs.onError);
      } else {
        log.e('[DIO][DATA]${data.toString()}');
      }
    }
    log.e('[DIO]<-- HTTP FAILED');

    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.v('[DIO][REQUEST]--> ${options.method} ${options.uri}');
    log.v('[DIO][BODY] ${options.data}');
    log.v('[DIO]--> END ${options.method}');

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.i('[DIO][RESPONSE]<-- ${response.statusCode} ${response.statusMessage ?? ''}');
    log.i('[DIO][URL] ${response.requestOptions.uri}');
    log.i('[DIO][BODY] ${response.requestOptions.data}');

    final data = response.data;
    if (data != null) {
      if (data is Map) {
        logJson(data, DioLogs.onResponse);
      } else {
        log.i('[DIO][DATA]${data.toString()}');
      }
    }
    log.i('[DIO]<-- END HTTP');
    return handler.next(response);
  }

  void logJson(Object input, DioLogs dioLogs) {
    var prettyString = encoder.convert(input);
    prettyString.split('\n').forEach((element) {
      if (dioLogs == DioLogs.onResponse) {
        log.i('[DIO][DATA]$element');
      } else if (dioLogs == DioLogs.onError) {
        log.e('[DIO][DATA]$element');
      }
    });
  }
}
