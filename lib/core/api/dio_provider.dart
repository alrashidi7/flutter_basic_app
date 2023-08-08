import 'dart:convert' as convert;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_basic_app/core/api/status_codes.dart';

import '../error/exceptions.dart';
import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({
    required this.client,
  }) {
    if (!kIsWeb) {
      (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        HttpClient? httpClient;
        httpClient?.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return httpClient!;
      };
    }
    client.options
      //..baseUrl = AppStrings.baseUrl
      ..responseType = ResponseType.json
      ..headers = {
        "Accept": "application/json",
        'Access-Control-Allow-Origin': '*'
      }
      ..validateStatus(200)
      ..followRedirects = false;
  }

  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameters, required bool sendToken}) async {
    // if (sendToken) {
    //   client.options.headers.addEntries({
    //     "Authorization": "Bearer ${await localDatabase.getToken()}"
    //   }.entries);
    // }
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResposneAsJson(response);
    } on DioException catch (error) {
      return _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      required bool sendToken}) async {
    // if (sendToken) {
    //   client.options.headers.addEntries({
    //     "Authorization": "Bearer ${await localDatabase.getToken()}"
    //   }.entries);
    // }
    try {
      final response =
          await client.post(path, queryParameters: queryParameters, data: body);
      return _handleResposneAsJson(response);
    } on DioException catch (error) {
      return _handleDioError(error);
    }
  }

  @override
  Future postFormData(String path,
      {FormData? body,
      required bool sendToken,
      Map<String, dynamic>? queryParameters}) async {
    // if (sendToken) {
    //   client.options.headers.addEntries({
    //     "Authorization": "Bearer ${await localDatabase.getToken()}"
    //   }.entries);
    // }
    try {
      final response =
          await client.post(path, queryParameters: queryParameters, data: body);
      return _handleResposneAsJson(response);
    } on DioException catch (error) {
      return _handleDioError(error);
    }
  }

  dynamic _handleResposneAsJson(Response<dynamic> response) {
    if (response.data.runtimeType != String) {
      return response.data;
    }
    return convert.json.decode(response.data);
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badCertificate:
        throw const UnauthorizedException('');
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
          case StatusCode.unauthorized:
            throw UnauthorizedException(error.response?.data['message'] ??
                error.response?.data['error']);
          case StatusCode.notFound:
            throw const NotFoundException();
        }
        throw BadRequestException(
            error.response?.data['message'] ?? error.response?.data['error']);
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException();
      case DioExceptionType.cancel:
        throw const InternalServerErrorException();

      default:
        throw const FormatDataException();
    }
  }
}
