// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_create_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseCreateRequestModel _$ExpenseCreateRequestModelFromJson(
  Map<String, dynamic> json,
) => _ExpenseCreateRequestModel(
  groupId: json['groupId'] as String,
  description: json['description'] as String,
  amount: (json['amount'] as num).toInt(),
  payments: (json['payments'] as List<dynamic>)
      .map((e) => Payment.fromJson(e as Map<String, dynamic>))
      .toList(),
  splits: (json['splits'] as List<dynamic>)
      .map((e) => Split.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ExpenseCreateRequestModelToJson(
  _ExpenseCreateRequestModel instance,
) => <String, dynamic>{
  'groupId': instance.groupId,
  'description': instance.description,
  'amount': instance.amount,
  'payments': instance.payments,
  'splits': instance.splits,
};

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  paidBy: json['paidBy'] as String,
  amount: (json['amount'] as num).toInt(),
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'paidBy': instance.paidBy,
  'amount': instance.amount,
};

_Split _$SplitFromJson(Map<String, dynamic> json) => _Split(
  userId: json['userId'] as String,
  owedAmount: (json['owedAmount'] as num).toInt(),
);

Map<String, dynamic> _$SplitToJson(_Split instance) => <String, dynamic>{
  'userId': instance.userId,
  'owedAmount': instance.owedAmount,
};
