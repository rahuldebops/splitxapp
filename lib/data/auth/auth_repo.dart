
import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/auth/models/login/login_request_model.dart';
import 'package:splitxapp/data/auth/models/login/login_response_model.dart';
import 'package:splitxapp/data/auth/models/register/register_request_model.dart';
import 'package:splitxapp/data/auth/models/register/register_response_model.dart';

abstract class AuthRepo {
  Future<Either<ApiException, RegisterResponseModel>> register(
    RegisterRequestModel req,
  );

  Future<Either<ApiException, LoginResponseModel>> login(
    LoginRequestModel req,
  );
}
