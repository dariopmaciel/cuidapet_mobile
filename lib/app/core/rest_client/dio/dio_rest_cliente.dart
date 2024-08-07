import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/interceptor/auth_interceptor.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/interceptor/auth_refresh_token_interceptor.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_cliente_exception.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_response.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;

  final _defaultOption = BaseOptions(
    baseUrl: Environments.param(Constants.ENV_BASE_URL_KEY) ?? '',
    connectTimeout: Duration(
      milliseconds: int.parse(
          Environments.param(Constants.ENV_REST_CLIENT_CONNECT_TIMEOUT_KEY) ??
              '0'),
    ),
    receiveTimeout: Duration(
      milliseconds: int.parse(
          Environments.param(Constants.ENV_REST_CLIENT_RECEIVE_TIMEOUT_KEY) ??
              '0'),
    ),
  );

  DioRestClient({
    required LocalStorage localStorage,
    required AppLogger log,
    required AuthStore authStore,
    required LocalSecureStorage localSecureStorage,
    BaseOptions? baseOptions,
  }) {
    _dio = Dio(baseOptions ?? _defaultOption);
    _dio.interceptors.addAll([
      AuthInterceptor(
        localStorage: localStorage,
        authStore: authStore,
      ),
      AuthRefreshTokenInterceptor(
        authStore: authStore,
        localStorage: localStorage,
        localSecureStorage: localSecureStorage,
        restClient: this,
        log: log,
      ),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    ]);
  }

  @override
  RestClient auth() {
    _defaultOption.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] = true;
    return this;
  }

  @override
  RestClient unAuth() {
    _defaultOption.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClienteException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClienteException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClienteException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClienteException(e); //possivel problema
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClienteException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );
      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClienteException(e); //ERRO AQUI?????
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverte<T>(
      Response<dynamic> response) async {
    return RestClientResponse(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  Never _throwRestClienteException(DioException dioError) {
    final response = dioError.response;
    throw RestClientException(
      error: dioError.error,
      message: response?.statusMessage,
      statusCode: response?.statusCode,
      response: RestClientResponse(
        data: response?.data,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
      ),
    );
  }
}
