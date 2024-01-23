abstract interface class AppLogger {
  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void error(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void warnning(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void info(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void append(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void closeAppend();
}
