import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:tots_flutter_test/core/network/connection_checker.dart';
import 'package:tots_flutter_test/core/network/try_api.dart';

typedef UploadProgressCallback = void Function(int count, int total);

abstract class DioHttpClient {
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
  Future<Response<dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
  Future<Response<dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}

class DioHttpClientImpl implements DioHttpClient {
  final ConnectionChecker connection;

  DioHttpClientImpl({
    required this.connection,
  });

  // config dio
  Future<Dio> _getDio() async {
    var dio = Dio(
      BaseOptions(
        baseUrl: 'https://agency-coda.uc.r.appspot.com',
        connectTimeout: const Duration(milliseconds: 25000),
        receiveTimeout: const Duration(milliseconds: 30000),
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
        ),
      );
    }

    return dio;
  }

  bool isNotValidResponse(int statusCode) {
    return statusCode != HttpStatus.ok && statusCode != HttpStatus.created;
  }

  // GET //
  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final dio = await _getDio();
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }

      if (!await connection.hasConnection()) {
        throw const SocketException('');
      }

      final response = await dio.get(path, queryParameters: queryParameters);

      if (isNotValidResponse(response.statusCode!)) {
        throw ServerException(message: response.data['message'], code: response.statusCode!);
      }
      return response;
    } on DioException catch (error) {
      throw ServerException(message: error.response!.data['message'], code: error.response!.data['statusCode']);
    }
  }

  // DELETE //
  @override
  Future<Response<dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final dio = await _getDio();
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }

      if (!await connection.hasConnection()) {
        throw const SocketException('');
      }

      final response = await dio.delete(
        path,
      );

      if (isNotValidResponse(response.statusCode!)) {
        throw ServerException(message: response.data['message'], code: response.statusCode!);
      }
      return response;
    } on DioException catch (error) {
      throw ServerException(message: error.response!.data['message'], code: error.response!.data['statusCode']);
    }
  }

  // POST //
  @override
  Future<Response<dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final dio = await _getDio();
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }

      if (!await connection.hasConnection()) {
        throw const SocketException('');
      }

      final response = await dio.post(path, queryParameters: queryParameters);

      if (isNotValidResponse(response.statusCode!)) {
        throw ServerException(message: response.data['message'], code: response.statusCode!);
      }
      return response;
    } on DioException catch (error) {
      throw ServerException(message: error.response!.data['message'], code: error.response!.data['statusCode']);
    }
  }
}
