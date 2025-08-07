// To parse this JSON data, do
//
//     final groupListResponseModel = groupListResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'group_list_response_model.freezed.dart';
part 'group_list_response_model.g.dart';

GroupListResponseModel groupListResponseModelFromJson(String str) => GroupListResponseModel.fromJson(json.decode(str));

String groupListResponseModelToJson(GroupListResponseModel data) => json.encode(data.toJson());

@freezed
class GroupListResponseModel with _$GroupListResponseModel {
    const factory GroupListResponseModel({
        @JsonKey(name: "result")
        required Result result,
        @JsonKey(name: "message")
        required String message,
        @JsonKey(name: "errorCode")
        required dynamic errorCode,
    }) = _GroupListResponseModel;

    factory GroupListResponseModel.fromJson(Map<String, dynamic> json) => _$GroupListResponseModelFromJson(json);
    
      @override
      // TODO: implement errorCode
      get errorCode => throw UnimplementedError();
    
      @override
      // TODO: implement message
      String get message => throw UnimplementedError();
    
      @override
      // TODO: implement result
      Result get result => throw UnimplementedError();
    
      @override
      Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
      }
}

@freezed
class Result with _$Result {
    const factory Result({
        @JsonKey(name: "data")
        required List<Datum> data,
        @JsonKey(name: "pageNumber")
        required int pageNumber,
        @JsonKey(name: "pageSize")
        required int pageSize,
        @JsonKey(name: "totalRecords")
        required int totalRecords,
    }) = _Result;

    factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
    
      @override
      // TODO: implement data
      List<Datum> get data => throw UnimplementedError();
    
      @override
      // TODO: implement pageNumber
      int get pageNumber => throw UnimplementedError();
    
      @override
      // TODO: implement pageSize
      int get pageSize => throw UnimplementedError();
    
      @override
      Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
      }
    
      @override
      // TODO: implement totalRecords
      int get totalRecords => throw UnimplementedError();
}

@freezed
class Datum with _$Datum {
    const factory Datum({
        @JsonKey(name: "groupId")
        required String groupId,
        @JsonKey(name: "name")
        required String name,
        @JsonKey(name: "currency")
        required String currency,
    }) = _Datum;

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
    
      @override
      // TODO: implement currency
      String get currency => throw UnimplementedError();
    
      @override
      // TODO: implement groupId
      String get groupId => throw UnimplementedError();
    
      @override
      // TODO: implement name
      String get name => throw UnimplementedError();
    
      @override
      Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
      }
}
