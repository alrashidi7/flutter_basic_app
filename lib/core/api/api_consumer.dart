import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    required bool sendToken,
  });
  Future<dynamic> post(String path,
      {Map<String, dynamic>? body,
      required bool sendToken,
      Map<String, dynamic>? queryParameters});
  Future<dynamic> postFormData(String path,
      {FormData? body,
      required bool sendToken,
      Map<String, dynamic>? queryParameters});
}
