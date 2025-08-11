// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseCreateResponseModel _$ExpenseCreateResponseModelFromJson(
  Map<String, dynamic> json,
) => _ExpenseCreateResponseModel(
  result: json['result'] as bool,
  message: json['message'] as String,
  errorCode: json['errorCode'],
);

Map<String, dynamic> _$ExpenseCreateResponseModelToJson(
  _ExpenseCreateResponseModel instance,
) => <String, dynamic>{
  'result': instance.result,
  'message': instance.message,
  'errorCode': instance.errorCode,
};
