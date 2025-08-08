import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/api_client.dart';
import 'package:splitxapp/core/constants.dart';
import 'package:splitxapp/core/endpoints.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/auth/auth_repo.dart';
import 'package:splitxapp/data/auth/models/login/login_request_model.dart';
import 'package:splitxapp/data/auth/models/login/login_response_model.dart';
import 'package:splitxapp/data/auth/models/refreshToken/refresh_token_request_model.dart';
import 'package:splitxapp/data/auth/models/register/register_request_model.dart';
import 'package:splitxapp/data/auth/models/register/register_response_model.dart';
import 'package:splitxapp/utils/logger.dart';
import 'package:splitxapp/services/token_service.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiClient _apiClient;
  AuthRepoImpl(this._apiClient);

  @override
  Future<Either<ApiException, RegisterResponseModel>> register(
      RegisterRequestModel req) async {
    try {
      final response = await _apiClient.post(
        "${AppConstants.baseUrl}/${Endpoints.authRegisterEndpoint}",
        registerRequestModelToJson(req),
      );
      Logger.write(response.toString());
      // Save tokens securely
      final result = RegisterResponseModel.fromJson(response.data!);
      await TokenService.saveTokens(
          accessToken: result.result.accessToken,
          refreshToken: result.result.refreshToken);
      return Right(result);
    } catch (e) {
      Logger.write(e.toString());
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, LoginResponseModel>> login(
      LoginRequestModel req) async {
    try {
      final response = await _apiClient.post(
        "${AppConstants.baseUrl}${Endpoints.authLoginEndpoint}",
        loginRequestModelToJson(req),
      );
      Logger.write(response.toString());
      final result = LoginResponseModel.fromJson(response.data!);
      await TokenService.saveTokens(
        accessToken: result.result.accessToken,
        refreshToken: result.result.refreshToken,
      );
      return Right(result);
    } catch (e) {
      Logger.write(e.toString());
      return Left(ApiException(e.toString()));
    }
  }

  Future<Either<ApiException, LoginResponseModel>> refreshToken(
      RefreshTokenRequestModel req) async {
    try {
      final response = await _apiClient.post(
        "${AppConstants.baseUrl}/Auth/refresh",
        req.toJson(),
      );
      Logger.write(response.toString());
      final result = LoginResponseModel.fromJson(response.data!);
      // Save new tokens
      await TokenService.saveTokens(
        accessToken: result.result.accessToken,
        refreshToken: result.result.refreshToken,
      );
      return Right(result);
    } catch (e) {
      Logger.write(e.toString());
      return Left(ApiException(e.toString()));
    }
  }
}
