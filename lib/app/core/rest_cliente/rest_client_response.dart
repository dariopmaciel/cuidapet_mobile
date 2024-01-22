class RestClientResponse<T> {
  T? data;
  int? statusCode;
  String? message;

  RestClientResponse({
    this.data,
    this.statusCode,
    this.message,
  });
}
