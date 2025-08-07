// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupListResponseModel _$GroupListResponseModelFromJson(
  Map<String, dynamic> json,
) => _GroupListResponseModel(
  result: Result.fromJson(json['result'] as Map<String, dynamic>),
  message: json['message'] as String,
  errorCode: json['errorCode'],
);

Map<String, dynamic> _$GroupListResponseModelToJson(
  _GroupListResponseModel instance,
) => <String, dynamic>{
  'result': instance.result,
  'message': instance.message,
  'errorCode': instance.errorCode,
};

_Result _$ResultFromJson(Map<String, dynamic> json) => _Result(
  data: (json['data'] as List<dynamic>)
      .map((e) => Datum.fromJson(e as Map<String, dynamic>))
      .toList(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalRecords: (json['totalRecords'] as num).toInt(),
);

Map<String, dynamic> _$ResultToJson(_Result instance) => <String, dynamic>{
  'data': instance.data,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
  'totalRecords': instance.totalRecords,
};

_Datum _$DatumFromJson(Map<String, dynamic> json) => _Datum(
  groupId: json['groupId'] as String,
  name: json['name'] as String,
  currency: json['currency'] as String,
);

Map<String, dynamic> _$DatumToJson(_Datum instance) => <String, dynamic>{
  'groupId': instance.groupId,
  'name': instance.name,
  'currency': instance.currency,
};
