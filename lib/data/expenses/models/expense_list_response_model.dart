// To parse this JSON data, do
//
//     final expenseListResponseModel = expenseListResponseModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'expense_list_response_model.freezed.dart';
part 'expense_list_response_model.g.dart';

ExpenseListResponseModel expenseListResponseModelFromJson(String str) => ExpenseListResponseModel.fromJson(json.decode(str));

String expenseListResponseModelToJson(ExpenseListResponseModel data) => json.encode(data.toJson());

@freezed
abstract class ExpenseListResponseModel with _$ExpenseListResponseModel {
    const factory ExpenseListResponseModel({
        required Result result,
        required String message,
        required dynamic errorCode,
    }) = _ExpenseListResponseModel;

    factory ExpenseListResponseModel.fromJson(Map<String, dynamic> json) => _$ExpenseListResponseModelFromJson(json);
}

@freezed
abstract class Result with _$Result {
    const factory Result({
        required List<Datum> data,
        required int pageNumber,
        required int pageSize,
        required int totalRecords,
    }) = _Result;

    factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@freezed
abstract class Datum with _$Datum {
    const factory Datum({
        required String id,
        required String groupId,
        required String description,
        required double amount,
        required String createdAt,
    }) = _Datum;

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}
