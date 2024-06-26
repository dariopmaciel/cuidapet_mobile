import 'package:dio/dio.dart';

import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';

// como boa prática, é executado sempre antes de um TIPO de chamada

class AuthInterceptor extends Interceptor {
  LocalStorage _localStorage;
  AppLogger _log;

  AuthInterceptor({
    required LocalStorage localStorage,
    required AppLogger log,
  })  : _localStorage = localStorage,
        _log = log;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Executado SEMPRE antes do envio da requisição

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Executado ANTES de responder para quem nos chamou
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Excutado SEMPRE antes de disparar o erro.
    super.onError(err, handler);
  }
}
