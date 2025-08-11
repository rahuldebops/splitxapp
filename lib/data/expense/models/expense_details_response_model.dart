// To parse this JSON data, do
//
//     final expenseDetailsResponseModel = expenseDetailsResponseModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'expense_details_response_model.freezed.dart';
part 'expense_details_response_model.g.dart';

ExpenseDetailsResponseModel expenseDetailsResponseModelFromJson(String str) => ExpenseDetailsResponseModel.fromJson(json.decode(str));

String expenseDetailsResponseModelToJson(ExpenseDetailsResponseModel data) => json.encode(data.toJson());

@freezed
abstract class ExpenseDetailsResponseModel with _$ExpenseDetailsResponseModel {
    const factory ExpenseDetailsResponseModel({
        required Result result,
        required String message,
        required dynamic errorCode,
    }) = _ExpenseDetailsResponseModel;

    factory ExpenseDetailsResponseModel.fromJson(Map<String, dynamic> json) => _$ExpenseDetailsResponseModelFromJson(json);
}

@freezed
abstract class Result with _$Result {
    const factory Result({
        required List<Payment> payments,
        required List<Split> splits,
        required String id,
        required String groupId,
        required String description,
        required double amount,
        required String createdAt,
    }) = _Result;

    factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@freezed
abstract class Payment with _$Payment {
    const factory Payment({
        required PaidBy paidBy,
        required double amount,
    }) = _Payment;

    factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
}

@freezed
abstract class PaidBy with _$PaidBy {
    const factory PaidBy({
        required String id,
        required String fullName,
        required String phone,
        required String email,
    }) = _PaidBy;

    factory PaidBy.fromJson(Map<String, dynamic> json) => _$PaidByFromJson(json);
}

@freezed
abstract class Split with _$Split {
    const factory Split({
        required PaidBy user,
        required double owedAmount,
    }) = _Split;

    factory Split.fromJson(Map<String, dynamic> json) => _$SplitFromJson(json);
}
