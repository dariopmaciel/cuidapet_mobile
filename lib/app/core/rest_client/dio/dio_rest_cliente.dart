import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_clienteException.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_response.dart';
import 'package:dio/dio.dart';

class DioRestCliente implements RestClient {
  late final Dio _dio;
  final _defaultOption = BaseOptions(
    baseUrl: Environments.param(Constants.ENV_BASE_URL_KEY) ?? '',
    // connectTimeout: Environments.param(Constants.ENV_REST_CLIENT_CONNET_TIMEOUT_KEY),
    connectTimeout: Duration(
      microseconds: int.parse(
        Environments.param(Constants.ENV_REST_CLIENT_CONNET_TIMEOUT_KEY) ?? '0',
      ),
    ),
    receiveTimeout: Duration(
      microseconds: int.parse(
        Environments.param(Constants.ENV_REST_CLIENT_RECIVE_TIMEOUT_KEY) ?? '0',
      ),
    ),
  );

  DioRestCliente({BaseOptions? baseOptions}) {
    _dio = Dio(baseOptions ?? _defaultOption);
  }

  @override
  RestClient auth() {
    _defaultOption.extra['auth_required'] = true;
    return this;
  }

  @override
  RestClient unAuth() {
    _defaultOption.extra['auth_required'] = false;
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
      final response = await _dio.delete(
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
  Future<RestClientResponse<T>> path<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(
        data: data,
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
  Future<RestClientResponse<T>> post<T>(String path,
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
  Future<RestClientResponse<T>> put<T>(String path,
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
  Future<RestClientResponse<T>> request<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(
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
      _throwRestClienteException(e);
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverte<T>(
      Response<dynamic> response) async {
    return RestClientResponse(
      data: response.data,
      statusCode: response.statusCode,
      message: response.statusMessage,
    );
  }

  // Never _throwRestClienteException(DioException dioError) {
  //   final response = dioError.response;

  //   throw RestClientException(
  //     error: dioError.error,
  //     message: response?.statusMessage,
  //     statusCode: response?.statusCode,
  //     response: RestClientResponse(
  //       data: response?.data,
  //       statusCode: response?.statusCode,
  //       statusMessage: response?.statusMessage,
  //     ),
  //   );
  // }
  Never _throwRestClienteException(DioException dioException) {
    final response = dioException.response;
    throw RestClientException(
      error: dioException.error,
      response: RestClientResponse(
        data: response?.data,
        statusCode: response?.statusCode,
        message: response?.statusMessage,
      ),
      message: response?.statusMessage,
      statusCode: response?.statusCode,
    );
  }
}
