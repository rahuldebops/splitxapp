// To parse this JSON data, do
//
//     final registerRequestModel = registerRequestModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'register_request_model.freezed.dart';
part 'register_request_model.g.dart';

RegisterRequestModel registerRequestModelFromJson(String str) => RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) => json.encode(data.toJson());

@freezed
abstract class RegisterRequestModel with _$RegisterRequestModel {
    const factory RegisterRequestModel({
        @JsonKey(name: "fullName")
        required String fullName,
        @JsonKey(name: "phone")
        required String phone,
        @JsonKey(name: "email")
        required String email,
        @JsonKey(name: "password")
        required String password,
    }) = _RegisterRequestModel;

    factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => _$RegisterRequestModelFromJson(json);
    
      @override
      Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
      }
}
