import 'dart:developer' as developer;

class PrettyLogger {
  void info(String message) {
    _log(message, level: 'INFO', color: '\x1B[32m'); // Green
  }

  void debug(String message) {
    _log(message, level: 'DEBUG', color: '\x1B[34m'); // Blue
  }

  void error(dynamic e, [StackTrace? stackTrace]) {
    final errorMessage = e.toString();
    final String stackTraceString = stackTrace?.toString() ?? 'No stack trace';
    final fullMessage = '$errorMessage\nStack Trace:\n$stackTraceString';
    _log(fullMessage, level: 'ERROR', color: '\x1B[31m'); // Red
  }

  void _log(String message, {required String level, required String color}) {
    final timestamp = DateTime.now();
    final formattedMessage = '$color[$level] $timestamp: $message\x1B[0m';
    developer.log(formattedMessage);
  }
}
