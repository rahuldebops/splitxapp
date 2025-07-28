import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/api_client.dart';
import 'package:splitxapp/core/constants.dart';
import 'package:splitxapp/core/endpoints.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/auth/auth_repo.dart';
import 'package:splitxapp/data/auth/models/login/login_request_model.dart';
import 'package:splitxapp/data/auth/models/login/login_response_model.dart';
import 'package:splitxapp/data/auth/models/register/register_request_model.dart';
import 'package:splitxapp/data/auth/models/register/register_response_model.dart';
import 'package:splitxapp/utils/logger.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiClient _apiClient;

  AuthRepoImpl(this._apiClient);

  @override
  Future<Either<ApiException, RegisterResponseModel>> register(
    RegisterRequestModel req,
  ) async {
    try {
      final response = await _apiClient.post(
       "${AppConstants.baseUrl}/${Endpoints.authRegisterEndpoint}",
        registerRequestModelToJson(req),
      );
      Logger.write(response.toString());
      return Right(RegisterResponseModel.fromJson(response.data!));
    } catch (e) {
      Logger.write(e.toString());
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, LoginResponseModel>> login(
    LoginRequestModel req,
  ) async {
    try {
      final response = await _apiClient.post(
        "${AppConstants.baseUrl}${Endpoints.authLoginEndpoint}",
        loginRequestModelToJson(req),
      );
      Logger.write(response.toString());
      return Right(LoginResponseModel.fromJson(response.data!));
    } catch (e) {
      Logger.write(e.toString());
      return Left(ApiException(e.toString()));
    }
  }
}
