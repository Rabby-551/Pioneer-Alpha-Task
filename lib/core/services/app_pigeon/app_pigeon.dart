import 'package:dio/dio.dart';

class AppPigeon {
  AppPigeon({required this.baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  final Dio _dio;
  final String baseUrl;

  /// Public GET/POST/PUT/DELETE wrappers
  Future<Response> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  }) {
    return _dio.get(path, queryParameters: query, data: data);
  }

  Future<Response> post(String path, {dynamic data, Options? options}) {
    return _dio.post(path, data: data, options: options);
  }

  Future<Response> put(String path, {dynamic data, Options? options}) {
    return _dio.put(path, data: data, options: options);
  }

  Future<Response> patch(String path, {dynamic data, Options? options}) {
    return _dio.patch(path, data: data, options: options);
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.delete(path,
        data: data, options: options, queryParameters: queryParameters);
  }
}
