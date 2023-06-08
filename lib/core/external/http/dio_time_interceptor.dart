import 'dart:convert';
import 'package:animenginamo/core/extensions/string_extension.dart';
import 'package:dio/dio.dart';


import '../../common_widgets/custom_logger.dart';

class DioTimeInterceptor extends Interceptor {
  final log = getLogger('DioTimeInterceptor');

  final JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['requestStartTime'] = DateTime.now().microsecondsSinceEpoch;
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final timeNow = DateTime.now().microsecondsSinceEpoch;
    final afterReponse = response.requestOptions.extra['requestStartTime'].toString().toInt()!;
    final responseTime = timeNow - afterReponse;
    double seconds = responseTime / 1000000;

    log.i('[DIO][RESPONSE TIME] ${seconds.toStringAsFixed(2)} seconds');

    return handler.next(response);
  }
}
