///custom error object to handle all type of error
abstract interface class Failure implements Exception {
  const Failure();
  StackTrace get stackTrace;

  String get title;

  String get error;

  String get description;

  @override
  String toString() {
    return '$title\n$error\n$stackTrace';
  }
}
