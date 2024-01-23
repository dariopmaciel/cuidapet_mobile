import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/helpers/eviroments.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client_exception.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client_response.dart';
import 'package:dio/dio.dart';

class DioResClient implements RestClient {
  late final Dio _dio;

  final _defaultOptions = BaseOptions(
    baseUrl: Enviroments.param(Constants.ENV_BASE_URL_KEY) ?? '',
    // connectTimeout: int.parse(Enviroments.param(Constants.ENV_REST_CLIENT_CONNECT_TIMEOUT_KEY)??'0'),
    // receiveTimeout: int.parse(Enviroments.param(Constants.ENV_REST_CLIENT_REVICE_TIMEOUT_KEY)??'0'),
    // connectTimeout: const Duration(milliseconds: 60000),
    // receiveTimeout: const Duration(milliseconds: 60000),
    connectTimeout: Duration(
      milliseconds: int.parse(
          Enviroments.param(Constants.ENV_REST_CLIENT_CONNECT_TIMEOUT_KEY) ??
              '0'),
    ),
    receiveTimeout: Duration(
      milliseconds: int.parse(
          Enviroments.param(Constants.ENV_REST_CLIENT_RECEIVE_TIMEOUT_KEY) ??
              '0'),
    ),
  );

  DioResClient({
    BaseOptions? baseOptions,
  }) {
    _dio = Dio(baseOptions ?? _defaultOptions);
  }

  @override
  RestClient auth() {
    _defaultOptions.extra['auth_required'] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _defaultOptions.extra['auth_required'] = false;
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
      // return RestClientResponse(
      //   data: response.data,
      //   statusCode: response.statusCode,
      //   message: response.statusMessage,
      // );
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      // } on DioError catch (e) {
      // final response = e.response;
      // throw RestClientException(
      //   error: e.error,
      //   response: RestClientResponse(
      //     data: response?.data,
      //     statusCode: response?.statusCode,
      //     message: response?.statusMessage,
      //   ),
      //   message: response?.statusMessage,
      //   statusCode: response?.statusCode,
      // );
      _thorwRestClienteException(e);
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
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _thorwRestClienteException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> path<T>(String path,
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
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _thorwRestClienteException(e);
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
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _thorwRestClienteException(e);
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
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _thorwRestClienteException(e);
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
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _thorwRestClienteException(e);
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverter<T>(
      Response<dynamic> response) async {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      message: response.statusMessage,
    );
  }

  Never _thorwRestClienteException(DioException dioException) {
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
