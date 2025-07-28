// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    _LoginResponseModel(
      result: Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String,
      errorCode: json['errorCode'],
    );

Map<String, dynamic> _$LoginResponseModelToJson(_LoginResponseModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'errorCode': instance.errorCode,
    };

_Result _$ResultFromJson(Map<String, dynamic> json) => _Result(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
);

Map<String, dynamic> _$ResultToJson(_Result instance) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
};
