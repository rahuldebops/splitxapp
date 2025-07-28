// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:splitxapp/core/constants.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/utils/logger.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.options.connectTimeout = const Duration(milliseconds: 9000);
    dio.options.receiveTimeout = const Duration(milliseconds: 9000);
  }

  Future<Response<Map<String, dynamic>>> post(
    String path,
    dynamic data,
  ) async {
    try {
      final String timeZone = await FlutterTimezone.getLocalTimezone();
      return await dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer ${AppConstants.token}",
            "X-TimeZone": timeZone,
          },
        ),
      );
    } on DioException catch (e) {
      Logger.write(e.response?.data["message"]);
      throw ApiException(e.response?.data["message"]);
    }
  }

  Future<Response<Map<String, dynamic>>> get(String path) async {
    try {
      return await dio.get(
        path,
        options: Options(
          headers: {
            "Authorization": "Bearer ${AppConstants.token}",
          },
        ),
      );
    } on DioException catch (e) {
      Logger.write(e.response?.data["message"]);
      throw ApiException(e.response?.data["message"]);
    }
  }
}

class MultiPartClient extends http.BaseClient {
  final http.Client _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.persistentConnection = false;
    request.headers["Content-Type"] = "application/json";
    return _httpClient.send(request);
  }
}
