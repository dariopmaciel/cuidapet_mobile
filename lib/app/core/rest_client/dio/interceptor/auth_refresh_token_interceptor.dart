import 'package:cuidapet_mobile/app/core/exceptions/expired_token_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_cliente_exception.dart';

import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

class AuthRefreshTokenInterceptor extends Interceptor {
  final AuthStore _authStore;
  final LocalStorage _localStorage; //atualizar token jwt
  final LocalSecureStorage _localSecureStorage;
  final RestClient _restClient;
  final AppLogger _log;

  AuthRefreshTokenInterceptor({
    required AuthStore authStore,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required RestClient restClient,
    required AppLogger log,
  })  : _authStore = authStore,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _restClient = restClient,
        _log = log;

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    try {
      final responseStatusCode = err.response?.statusCode ?? 0;
      final requestPath = err.requestOptions.path;

      if (responseStatusCode == 403 || responseStatusCode == 401) {
        if (requestPath != '/auth/refresh') {
          final authRequired = err.requestOptions
                  .extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] ??
              false;
          if (authRequired) {
            _log.info('################# Refresh Token #################');
            await _refreshToken(err);
            await _retryRequest(err, handler);
            _log.info('############# Refresh Token Sucesso #############');
          } else {
            throw err;
          }
        } else {
          throw err;
        }
      } else {
        throw err;
      }
    } on ExpiredTokenException {
      _authStore.logout();
      handler.next(err);
    } on DioException catch (e) {
      handler.next(e);
    } catch (e, s) {
      _log.error('Erro rest cliente', e, s);
      handler.next(err);
    } finally {
      _log.closeAppend();
    }
  }

  Future<void> _refreshToken(DioException err) async {
    try {
  final refreshToken = await _localSecureStorage
      .read(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY);
  
  if (refreshToken == null) {
    throw ExpiredTokenException();
  }
  final resultRefresh = await _restClient.auth().put('/auth/refresh', data: {
    'refresh_token': refreshToken,
  });
  await _localStorage.write<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY,
      resultRefresh.data['access_token']);
  
  await _localSecureStorage.write(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY,
      resultRefresh.data['refresh_token']);
} on RestClientException catch (e, s) {
  _log.error("Erro ao tentar fazer refresh_token", e, s);
  throw ExpiredTokenException();
}
  }

  Future<void> _retryRequest(
      DioException err, ErrorInterceptorHandler handler) async {
    _log.info(
        '########### Retry Request (${err.requestOptions.path}) ############');
    final requestOptions = err.requestOptions;
    final result = await _restClient.request(
      requestOptions.path,
      method: requestOptions.method,
      data: requestOptions.data,
      headers: requestOptions.headers,
      queryParameters: requestOptions.queryParameters,
    );
    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
      ),
    );
  }
}
