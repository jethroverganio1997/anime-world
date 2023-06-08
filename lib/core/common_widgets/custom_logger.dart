import 'package:logger/logger.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

Logger getLogger(String className) => Logger(printer: CustomLogPrinter(className));

class CustomLogPrinter extends LogPrinter {
  CustomLogPrinter(this.className);

  final String className;

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];
    return [color!('$emoji $className | ${event.message}')];
  }
}
