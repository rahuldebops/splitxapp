import 'package:dio/dio.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:splitxapp/core/constants.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/services/token_service.dart';
import 'package:splitxapp/utils/logger.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.options.connectTimeout = const Duration(milliseconds: 9000);
    dio.options.receiveTimeout = const Duration(milliseconds: 9000);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await TokenService.getAccessToken();
          final timeZone = await FlutterTimezone.getLocalTimezone();
          if (accessToken != null && accessToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          options.headers['X-TimeZone'] = timeZone;
          handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            // Try refresh
            final refreshed = await _tryRefreshToken();
            if (refreshed) {
              final requestOptions = e.requestOptions;
              requestOptions.headers['Authorization'] =
                  'Bearer ${(await TokenService.getAccessToken()) ?? ""}';
              final cloned = await dio.fetch(requestOptions);
              return handler.resolve(cloned);
            } else {
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,
                  error: 'Unauthorized',
                  type: DioExceptionType.badResponse,
                  response: e.response,
                ),
              );
            }
          }
          handler.next(e);
        },
      ),
    );
  }

  Future<bool> _tryRefreshToken() async {
    final refreshToken = await TokenService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return false;
    try {
      final res = await dio.post(
        '${AppConstants.baseUrl}/Auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      if (res.statusCode == 200 && res.data != null) {
        final accessToken = res.data['result']?['accessToken'] ?? "";
        final newRefreshToken = res.data['result']?['refreshToken'] ?? "";
        if (accessToken.isNotEmpty && newRefreshToken.isNotEmpty) {
          await TokenService.saveTokens(
            accessToken: accessToken,
            refreshToken: newRefreshToken,
          );
          return true;
        }
      }
    } catch (_) {}
    await TokenService.clearTokens();
    return false;
  }

  Future<Response<Map<String, dynamic>>> post(String path, dynamic data) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw ApiException(e.response?.data["message"] ?? "POST error");
    }
  }

  Future<Response<Map<String, dynamic>>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiException(e.response?.data["message"] ?? "GET error");
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
