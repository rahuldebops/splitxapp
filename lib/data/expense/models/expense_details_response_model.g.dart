// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseDetailsResponseModel _$ExpenseDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => _ExpenseDetailsResponseModel(
  result: Result.fromJson(json['result'] as Map<String, dynamic>),
  message: json['message'] as String,
  errorCode: json['errorCode'],
);

Map<String, dynamic> _$ExpenseDetailsResponseModelToJson(
  _ExpenseDetailsResponseModel instance,
) => <String, dynamic>{
  'result': instance.result,
  'message': instance.message,
  'errorCode': instance.errorCode,
};

_Result _$ResultFromJson(Map<String, dynamic> json) => _Result(
  payments: (json['payments'] as List<dynamic>)
      .map((e) => Payment.fromJson(e as Map<String, dynamic>))
      .toList(),
  splits: (json['splits'] as List<dynamic>)
      .map((e) => Split.fromJson(e as Map<String, dynamic>))
      .toList(),
  id: json['id'] as String,
  groupId: json['groupId'] as String,
  description: json['description'] as String,
  amount: (json['amount'] as num).toDouble(),
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$ResultToJson(_Result instance) => <String, dynamic>{
  'payments': instance.payments,
  'splits': instance.splits,
  'id': instance.id,
  'groupId': instance.groupId,
  'description': instance.description,
  'amount': instance.amount,
  'createdAt': instance.createdAt,
};

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  paidBy: PaidBy.fromJson(json['paidBy'] as Map<String, dynamic>),
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'paidBy': instance.paidBy,
  'amount': instance.amount,
};

_PaidBy _$PaidByFromJson(Map<String, dynamic> json) => _PaidBy(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$PaidByToJson(_PaidBy instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'phone': instance.phone,
  'email': instance.email,
};

_Split _$SplitFromJson(Map<String, dynamic> json) => _Split(
  user: PaidBy.fromJson(json['user'] as Map<String, dynamic>),
  owedAmount: (json['owedAmount'] as num).toDouble(),
);

Map<String, dynamic> _$SplitToJson(_Split instance) => <String, dynamic>{
  'user': instance.user,
  'owedAmount': instance.owedAmount,
};
