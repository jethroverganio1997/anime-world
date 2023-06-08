import 'package:dio/dio.dart';

import 'error_const.dart';
import 'failure.dart';

abstract class HttpException extends DioException implements Failure {
  HttpException(this.dioError) : super(requestOptions: dioError.requestOptions, response: dioError.response);

  final DioException dioError;

  @override
  StackTrace get stackTrace => dioError.stackTrace;

  @override
  String get title => 'Error!';

  @override
  String get error => 'Unknown Error';

  @override
  String get description {
    var msg = 'DIOERROR [$type]: $message' '- ${dioError.error}';
    msg += '\nRESPONSE DATA:${response?.data}';
    msg += '\nSOURCE STACK:\n$stackTrace';
    return msg;
  }
}

class NoInternetConnectionException extends HttpException {
  NoInternetConnectionException(super.dioError);

  @override
  String get error => ErrorConst.noInternetMessage;

  @override
  String get title => 'Internet';
}

class TimeOutException extends HttpException {
  TimeOutException(super.dioError);

  @override
  String get error => ErrorConst.connectionTimeOutMessage;
}

class AbortionException extends HttpException {
  AbortionException(super.dioError);

  @override
  String get error => ErrorConst.connectionTimeOutMessage;
}

class UnhandleException extends HttpException {
  UnhandleException(super.dioError);

  @override
  String get error => ErrorConst.unhandledErrorMessage;
}

class ApiException extends HttpException {
  ApiException(super.dioError);

  @override
  String get error {
    return dioError.toString();
  }
}
