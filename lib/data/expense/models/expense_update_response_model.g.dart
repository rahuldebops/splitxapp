// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_update_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseUpdateResponseModel _$ExpenseUpdateResponseModelFromJson(
  Map<String, dynamic> json,
) => _ExpenseUpdateResponseModel(
  result: json['result'] as bool,
  message: json['message'] as String,
  errorCode: json['errorCode'],
);

Map<String, dynamic> _$ExpenseUpdateResponseModelToJson(
  _ExpenseUpdateResponseModel instance,
) => <String, dynamic>{
  'result': instance.result,
  'message': instance.message,
  'errorCode': instance.errorCode,
};
