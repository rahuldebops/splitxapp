// To parse this JSON data, do
//
//     final expenseCreateRequestModel = expenseCreateRequestModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'expense_create_request_model.freezed.dart';
part 'expense_create_request_model.g.dart';

ExpenseCreateRequestModel expenseCreateRequestModelFromJson(String str) => ExpenseCreateRequestModel.fromJson(json.decode(str));

String expenseCreateRequestModelToJson(ExpenseCreateRequestModel data) => json.encode(data.toJson());

@freezed
abstract class ExpenseCreateRequestModel with _$ExpenseCreateRequestModel {
    const factory ExpenseCreateRequestModel({
        required String groupId,
        required String description,
        required int amount,
        required List<Payment> payments,
        required List<Split> splits,
    }) = _ExpenseCreateRequestModel;

    factory ExpenseCreateRequestModel.fromJson(Map<String, dynamic> json) => _$ExpenseCreateRequestModelFromJson(json);
}

@freezed
abstract class Payment with _$Payment {
    const factory Payment({
        required String paidBy,
        required int amount,
    }) = _Payment;

    factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
}

@freezed
abstract class Split with _$Split {
    const factory Split({
        required String userId,
        required int owedAmount,
    }) = _Split;

    factory Split.fromJson(Map<String, dynamic> json) => _$SplitFromJson(json);
}
