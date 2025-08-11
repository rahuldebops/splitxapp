// To parse this JSON data, do
//
//     final groupListResponseModel = groupListResponseModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'group_list_response_model.freezed.dart';
part 'group_list_response_model.g.dart';

GroupListResponseModel groupListResponseModelFromJson(String str) => GroupListResponseModel.fromJson(json.decode(str));

String groupListResponseModelToJson(GroupListResponseModel data) => json.encode(data.toJson());

@freezed
abstract class GroupListResponseModel with _$GroupListResponseModel {
    const factory GroupListResponseModel({
        required Result result,
        required String message,
        required dynamic errorCode,
    }) = _GroupListResponseModel;

    factory GroupListResponseModel.fromJson(Map<String, dynamic> json) => _$GroupListResponseModelFromJson(json);
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
        required String groupId,
        required String name,
        required String currency,
    }) = _Datum;

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}
