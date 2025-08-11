// To parse this JSON data, do
//
//     final expenseUpdateResponseModel = expenseUpdateResponseModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'expense_update_response_model.freezed.dart';
part 'expense_update_response_model.g.dart';

ExpenseUpdateResponseModel expenseUpdateResponseModelFromJson(String str) => ExpenseUpdateResponseModel.fromJson(json.decode(str));

String expenseUpdateResponseModelToJson(ExpenseUpdateResponseModel data) => json.encode(data.toJson());

@freezed
abstract class ExpenseUpdateResponseModel with _$ExpenseUpdateResponseModel {
    const factory ExpenseUpdateResponseModel({
        required bool result,
        required String message,
        required dynamic errorCode,
    }) = _ExpenseUpdateResponseModel;

    factory ExpenseUpdateResponseModel.fromJson(Map<String, dynamic> json) => _$ExpenseUpdateResponseModelFromJson(json);
}
