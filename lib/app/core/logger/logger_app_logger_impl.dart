import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:logger/logger.dart';

class LoggerAppLoggerImpl implements AppLogger {
  final logger = Logger();
  //criado uma lista para o append
  // List<String> messages = [];
  //ou
  var messages = <String>[];

  //podendo ser com retorno tb
  // @override
  // void debug(message, [erro, StackTrace? stackTrace]) {
  //   return logger.d(message, error: erro, stackTrace: stackTrace);
  // }

  @override
  void debug(message, [erro, StackTrace? stackTrace]) =>
      //podendo ser com retorno tb
      logger.d(message, error: erro, stackTrace: stackTrace);

  @override
  void info(message, [erro, StackTrace? stackTrace]) =>
      logger.e(message, error: erro, stackTrace: stackTrace);

  @override
  void error(message, [erro, StackTrace? stackTrace]) =>
      logger.i(message, error: erro, stackTrace: stackTrace);

  @override
  void warnning(message, [erro, StackTrace? stackTrace]) =>
      logger.w(message, error: erro, stackTrace: stackTrace);

  @override
  void append(message) {
    messages.add(message);
  }

  @override
  void closeAppend() {
    // logger.i(messages.join('\n'));
    info(messages.join('\n'));
    messages = [];
  }
}
