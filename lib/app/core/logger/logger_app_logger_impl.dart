
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:logger/logger.dart';

class LoggerAppLoggerImpl implements AppLogger {

  final logger = Logger();
  
  @override
  void append(message, [error, StackTrace? stackTrace]) {
    // TODO: implement append
  }
  
  @override
  void closeAppend() {
    // TODO: implement closeAppend
  }
  
  @override
  void debug(message, [error, StackTrace? stackTrace]) {
    // TODO: implement debug
  }
  
  @override
  void error(message, [error, StackTrace? stackTrace]) {
    // TODO: implement error
  }
  
  @override
  void info(message, [error, StackTrace? stackTrace]) {
    // TODO: implement info
  }
  
  @override
  void warnning(message, [error, StackTrace? stackTrace]) {
    // TODO: implement warnning
  }
  
}