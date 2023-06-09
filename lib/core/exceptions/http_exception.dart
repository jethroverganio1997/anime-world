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

  @override
  String get description => dioError.toString();
}

class TimeOutException extends HttpException {
  TimeOutException(super.dioError);

  @override
  String get error => ErrorConst.connectionTimeOutMessage;

  @override
  String get description => dioError.toString();
}

class AbortedException extends HttpException {
  AbortedException(super.dioError);

  @override
  String get error => ErrorConst.connectionTimeOutMessage;

  @override
  String get description => dioError.toString();
}

class UnhandleException extends HttpException {
  UnhandleException(super.dioError);

  @override
  String get error => ErrorConst.unhandledErrorMessage;

  @override
  String get description => dioError.toString();
}

class ApiException extends HttpException {
  ApiException(super.dioError);

  @override
  String get error => 'Api Error';

  @override
  String get description => dioError.toString();
}
