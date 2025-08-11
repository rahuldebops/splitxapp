// To parse this JSON data, do
//
//     final refreshTokenRequestModel = refreshTokenRequestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'refresh_token_request_model.freezed.dart';
part 'refresh_token_request_model.g.dart';

RefreshTokenRequestModel refreshTokenRequestModelFromJson(String str) => RefreshTokenRequestModel.fromJson(json.decode(str));

String refreshTokenRequestModelToJson(RefreshTokenRequestModel data) => json.encode(data.toJson());

@freezed
abstract class RefreshTokenRequestModel with _$RefreshTokenRequestModel {
    const factory RefreshTokenRequestModel({
        @JsonKey(name: "refreshToken")
        required String refreshToken,
    }) = _RefreshTokenRequestModel;

    factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) => _$RefreshTokenRequestModelFromJson(json);
    
      @override
      Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
      }
}
