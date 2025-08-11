// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_fetch_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupMemberFetchResponseModel _$GroupMemberFetchResponseModelFromJson(
  Map<String, dynamic> json,
) => _GroupMemberFetchResponseModel(
  result: (json['result'] as List<dynamic>)
      .map((e) => Result.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String,
  errorCode: json['errorCode'],
);

Map<String, dynamic> _$GroupMemberFetchResponseModelToJson(
  _GroupMemberFetchResponseModel instance,
) => <String, dynamic>{
  'result': instance.result,
  'message': instance.message,
  'errorCode': instance.errorCode,
};

_Result _$ResultFromJson(Map<String, dynamic> json) => _Result(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$ResultToJson(_Result instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'phone': instance.phone,
  'email': instance.email,
};
