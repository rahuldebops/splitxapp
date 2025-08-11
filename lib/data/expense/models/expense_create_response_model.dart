// To parse this JSON data, do
//
//     final expenseCreateResponseModel = expenseCreateResponseModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'expense_create_response_model.freezed.dart';
part 'expense_create_response_model.g.dart';

ExpenseCreateResponseModel expenseCreateResponseModelFromJson(String str) => ExpenseCreateResponseModel.fromJson(json.decode(str));

String expenseCreateResponseModelToJson(ExpenseCreateResponseModel data) => json.encode(data.toJson());

@freezed
abstract class ExpenseCreateResponseModel with _$ExpenseCreateResponseModel {
    const factory ExpenseCreateResponseModel({
        required bool result,
        required String message,
        required dynamic errorCode,
    }) = _ExpenseCreateResponseModel;

    factory ExpenseCreateResponseModel.fromJson(Map<String, dynamic> json) => _$ExpenseCreateResponseModelFromJson(json);
}
