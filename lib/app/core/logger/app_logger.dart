//Cria um contrato de toda extrutura de LOG do app

abstract interface class AppLogger {
  void debug(dynamic message, [dynamic erro, StackTrace? stackTrace]);

  void error(dynamic message, [dynamic erro, StackTrace? stackTrace]);
  void warnning(dynamic message, [dynamic erro, StackTrace? stackTrace]);
  void info(dynamic message, [dynamic erro, StackTrace? stackTrace]);
  void append(
    dynamic message, /* [dynamic erro, StackTrace? stackTrace, ]*/ );
  void closeAppend();
}
