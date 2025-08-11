// To parse this JSON data, do
//
//     final groupMemberFetchResponseModel = groupMemberFetchResponseModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'group_member_fetch_response_model.freezed.dart';
part 'group_member_fetch_response_model.g.dart';

GroupMemberFetchResponseModel groupMemberFetchResponseModelFromJson(String str) => GroupMemberFetchResponseModel.fromJson(json.decode(str));

String groupMemberFetchResponseModelToJson(GroupMemberFetchResponseModel data) => json.encode(data.toJson());

@freezed
abstract class GroupMemberFetchResponseModel with _$GroupMemberFetchResponseModel {
    const factory GroupMemberFetchResponseModel({
        required List<Result> result,
        required String message,
        required dynamic errorCode,
    }) = _GroupMemberFetchResponseModel;

    factory GroupMemberFetchResponseModel.fromJson(Map<String, dynamic> json) => _$GroupMemberFetchResponseModelFromJson(json);
}

@freezed
abstract class Result with _$Result {
    const factory Result({
        required String id,
        required String fullName,
        required String phone,
        required String email,
    }) = _Result;

    factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
