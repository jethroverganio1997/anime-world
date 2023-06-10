import 'package:dio/dio.dart';

import '../../exceptions/http_exception.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeOutException(err);
      case DioExceptionType.badResponse:
        throw ApiException(err);
      case DioExceptionType.cancel:
        throw AbortedException(err);
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err);
      default:
        throw UnhandleException(err);
    }
  }
}
