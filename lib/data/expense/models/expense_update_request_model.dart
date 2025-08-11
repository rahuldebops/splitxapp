// To parse this JSON data, do
//
//     final expenseUpdateRequestModel = expenseUpdateRequestModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'expense_update_request_model.freezed.dart';
part 'expense_update_request_model.g.dart';

ExpenseUpdateRequestModel expenseUpdateRequestModelFromJson(String str) => ExpenseUpdateRequestModel.fromJson(json.decode(str));

String expenseUpdateRequestModelToJson(ExpenseUpdateRequestModel data) => json.encode(data.toJson());

@freezed
class ExpenseUpdateRequestModel with _$ExpenseUpdateRequestModel {
    const factory ExpenseUpdateRequestModel({
        required String expenseId,
        required String groupId,
        required String description,
        required int amount,
        required List<Payment> payments,
        required List<Split> splits,
    }) = _ExpenseUpdateRequestModel;

    factory ExpenseUpdateRequestModel.fromJson(Map<String, dynamic> json) => _$ExpenseUpdateRequestModelFromJson(json);
}

@freezed
class Payment with _$Payment {
    const factory Payment({
        required String paidBy,
        required int amount,
    }) = _Payment;

    factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
}

@freezed
class Split with _$Split {
    const factory Split({
        required String userId,
        required int owedAmount,
    }) = _Split;

    factory Split.fromJson(Map<String, dynamic> json) => _$SplitFromJson(json);
}
