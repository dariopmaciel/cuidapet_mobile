import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:dio/dio.dart';

import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';

// como boa prática, é executado sempre antes de um TIPO de chamada

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final AppLogger _log;

  AuthInterceptor({
    required LocalStorage localStorage,
    required AppLogger log,
  })  : _localStorage = localStorage,
        _log = log;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Executado SEMPRE antes do envio da requisição
    //antes de sair do app
    final authRequired =
        options.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;
    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
      if (accessToken == null) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: "Expire Token",
            // type: DioErrorType.cancel,
            //substituido por:
            type: DioExceptionType.cancel,
          ),
        );
      }
      //se authorization for verdadeira add accesstoken
      options.headers["Authorization"] = accessToken;
    } else {
      //se authorization for falso remove
      options.headers.remove('Authorization');
    }
    handler.next(options);
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
