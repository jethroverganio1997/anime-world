import 'package:flutter/cupertino.dart';

import 'failure.dart';

@immutable
abstract class FailureException implements Failure {
  const FailureException();
  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  String get error => 'Unhandled Error';

  @override
  String get title => 'Error';

  @override
  String get description => '';
}

class ErrorDetails extends FailureException {
  const ErrorDetails({
    required this.error,
    this.description = '',
    this.stackTrace = StackTrace.empty,
  });

  @override
  final StackTrace stackTrace;
  @override
  final String error;
  @override
  final String description;
}

class AbortException extends FailureException {}
