// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'register_response_model.freezed.dart';
part 'register_response_model.g.dart';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

@freezed
class RegisterResponseModel with _$RegisterResponseModel {
    const factory RegisterResponseModel({
        @JsonKey(name: "result")
        required Result result,
        @JsonKey(name: "message")
        required String message,
        @JsonKey(name: "errorCode")
        required dynamic errorCode,
    }) = _RegisterResponseModel;

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => _$RegisterResponseModelFromJson(json);
    
      @override
      // TODO: implement errorCode
      get errorCode => throw UnimplementedError();
    
      @override
      // TODO: implement message
      String get message => throw UnimplementedError();
    
      @override
      // TODO: implement result
      Result get result => throw UnimplementedError();
    
      @override
      Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
      }
}

@freezed
class Result with _$Result {
    const factory Result({
        @JsonKey(name: "accessToken")
        required String accessToken,
        @JsonKey(name: "refreshToken")
        required String refreshToken,
    }) = _Result;

    factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
    
      @override
      // TODO: implement accessToken
      String get accessToken => throw UnimplementedError();
    
      @override
      // TODO: implement refreshToken
      String get refreshToken => throw UnimplementedError();
    
      @override
      Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
      }
}
