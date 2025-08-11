// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'login_request_model.freezed.dart';
part 'login_request_model.g.dart';

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

@freezed
abstract class LoginRequestModel with _$LoginRequestModel {
  const factory LoginRequestModel({
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "password") required String password,
  }) = _LoginRequestModel;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
