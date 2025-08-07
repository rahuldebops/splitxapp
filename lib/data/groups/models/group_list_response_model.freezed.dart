// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupListResponseModel {

@JsonKey(name: "result") Result get result;@JsonKey(name: "message") String get message;@JsonKey(name: "errorCode") dynamic get errorCode;
/// Create a copy of GroupListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupListResponseModelCopyWith<GroupListResponseModel> get copyWith => _$GroupListResponseModelCopyWithImpl<GroupListResponseModel>(this as GroupListResponseModel, _$identity);

  /// Serializes this GroupListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupListResponseModel&&(identical(other.result, result) || other.result == result)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorCode, errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,message,const DeepCollectionEquality().hash(errorCode));

@override
String toString() {
  return 'GroupListResponseModel(result: $result, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $GroupListResponseModelCopyWith<$Res>  {
  factory $GroupListResponseModelCopyWith(GroupListResponseModel value, $Res Function(GroupListResponseModel) _then) = _$GroupListResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "result") Result result,@JsonKey(name: "message") String message,@JsonKey(name: "errorCode") dynamic errorCode
});


$ResultCopyWith<$Res> get result;

}
/// @nodoc
class _$GroupListResponseModelCopyWithImpl<$Res>
    implements $GroupListResponseModelCopyWith<$Res> {
  _$GroupListResponseModelCopyWithImpl(this._self, this._then);

  final GroupListResponseModel _self;
  final $Res Function(GroupListResponseModel) _then;

/// Create a copy of GroupListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? message = null,Object? errorCode = freezed,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of GroupListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res> get result {
  
  return $ResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [GroupListResponseModel].
extension GroupListResponseModelPatterns on GroupListResponseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupListResponseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupListResponseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupListResponseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "result")  Result result, @JsonKey(name: "message")  String message, @JsonKey(name: "errorCode")  dynamic errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupListResponseModel() when $default != null:
return $default(_that.result,_that.message,_that.errorCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "result")  Result result, @JsonKey(name: "message")  String message, @JsonKey(name: "errorCode")  dynamic errorCode)  $default,) {final _that = this;
switch (_that) {
case _GroupListResponseModel():
return $default(_that.result,_that.message,_that.errorCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "result")  Result result, @JsonKey(name: "message")  String message, @JsonKey(name: "errorCode")  dynamic errorCode)?  $default,) {final _that = this;
switch (_that) {
case _GroupListResponseModel() when $default != null:
return $default(_that.result,_that.message,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupListResponseModel implements GroupListResponseModel {
  const _GroupListResponseModel({@JsonKey(name: "result") required this.result, @JsonKey(name: "message") required this.message, @JsonKey(name: "errorCode") required this.errorCode});
  factory _GroupListResponseModel.fromJson(Map<String, dynamic> json) => _$GroupListResponseModelFromJson(json);

@override@JsonKey(name: "result") final  Result result;
@override@JsonKey(name: "message") final  String message;
@override@JsonKey(name: "errorCode") final  dynamic errorCode;

/// Create a copy of GroupListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupListResponseModelCopyWith<_GroupListResponseModel> get copyWith => __$GroupListResponseModelCopyWithImpl<_GroupListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupListResponseModel&&(identical(other.result, result) || other.result == result)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorCode, errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,message,const DeepCollectionEquality().hash(errorCode));

@override
String toString() {
  return 'GroupListResponseModel(result: $result, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$GroupListResponseModelCopyWith<$Res> implements $GroupListResponseModelCopyWith<$Res> {
  factory _$GroupListResponseModelCopyWith(_GroupListResponseModel value, $Res Function(_GroupListResponseModel) _then) = __$GroupListResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "result") Result result,@JsonKey(name: "message") String message,@JsonKey(name: "errorCode") dynamic errorCode
});


@override $ResultCopyWith<$Res> get result;

}
/// @nodoc
class __$GroupListResponseModelCopyWithImpl<$Res>
    implements _$GroupListResponseModelCopyWith<$Res> {
  __$GroupListResponseModelCopyWithImpl(this._self, this._then);

  final _GroupListResponseModel _self;
  final $Res Function(_GroupListResponseModel) _then;

/// Create a copy of GroupListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? message = null,Object? errorCode = freezed,}) {
  return _then(_GroupListResponseModel(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of GroupListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res> get result {
  
  return $ResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// @nodoc
mixin _$Result {

@JsonKey(name: "data") List<Datum> get data;@JsonKey(name: "pageNumber") int get pageNumber;@JsonKey(name: "pageSize") int get pageSize;@JsonKey(name: "totalRecords") int get totalRecords;
/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultCopyWith<Result> get copyWith => _$ResultCopyWithImpl<Result>(this as Result, _$identity);

  /// Serializes this Result to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Result&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalRecords, totalRecords) || other.totalRecords == totalRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),pageNumber,pageSize,totalRecords);

@override
String toString() {
  return 'Result(data: $data, pageNumber: $pageNumber, pageSize: $pageSize, totalRecords: $totalRecords)';
}


}

/// @nodoc
abstract mixin class $ResultCopyWith<$Res>  {
  factory $ResultCopyWith(Result value, $Res Function(Result) _then) = _$ResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "data") List<Datum> data,@JsonKey(name: "pageNumber") int pageNumber,@JsonKey(name: "pageSize") int pageSize,@JsonKey(name: "totalRecords") int totalRecords
});




}
/// @nodoc
class _$ResultCopyWithImpl<$Res>
    implements $ResultCopyWith<$Res> {
  _$ResultCopyWithImpl(this._self, this._then);

  final Result _self;
  final $Res Function(Result) _then;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? pageNumber = null,Object? pageSize = null,Object? totalRecords = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<Datum>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalRecords: null == totalRecords ? _self.totalRecords : totalRecords // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Result].
extension ResultPatterns on Result {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Result value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Result value)  $default,){
final _that = this;
switch (_that) {
case _Result():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Result value)?  $default,){
final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "data")  List<Datum> data, @JsonKey(name: "pageNumber")  int pageNumber, @JsonKey(name: "pageSize")  int pageSize, @JsonKey(name: "totalRecords")  int totalRecords)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that.data,_that.pageNumber,_that.pageSize,_that.totalRecords);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "data")  List<Datum> data, @JsonKey(name: "pageNumber")  int pageNumber, @JsonKey(name: "pageSize")  int pageSize, @JsonKey(name: "totalRecords")  int totalRecords)  $default,) {final _that = this;
switch (_that) {
case _Result():
return $default(_that.data,_that.pageNumber,_that.pageSize,_that.totalRecords);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "data")  List<Datum> data, @JsonKey(name: "pageNumber")  int pageNumber, @JsonKey(name: "pageSize")  int pageSize, @JsonKey(name: "totalRecords")  int totalRecords)?  $default,) {final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that.data,_that.pageNumber,_that.pageSize,_that.totalRecords);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Result implements Result {
  const _Result({@JsonKey(name: "data") required final  List<Datum> data, @JsonKey(name: "pageNumber") required this.pageNumber, @JsonKey(name: "pageSize") required this.pageSize, @JsonKey(name: "totalRecords") required this.totalRecords}): _data = data;
  factory _Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

 final  List<Datum> _data;
@override@JsonKey(name: "data") List<Datum> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override@JsonKey(name: "pageNumber") final  int pageNumber;
@override@JsonKey(name: "pageSize") final  int pageSize;
@override@JsonKey(name: "totalRecords") final  int totalRecords;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResultCopyWith<_Result> get copyWith => __$ResultCopyWithImpl<_Result>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Result&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalRecords, totalRecords) || other.totalRecords == totalRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),pageNumber,pageSize,totalRecords);

@override
String toString() {
  return 'Result(data: $data, pageNumber: $pageNumber, pageSize: $pageSize, totalRecords: $totalRecords)';
}


}

/// @nodoc
abstract mixin class _$ResultCopyWith<$Res> implements $ResultCopyWith<$Res> {
  factory _$ResultCopyWith(_Result value, $Res Function(_Result) _then) = __$ResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "data") List<Datum> data,@JsonKey(name: "pageNumber") int pageNumber,@JsonKey(name: "pageSize") int pageSize,@JsonKey(name: "totalRecords") int totalRecords
});




}
/// @nodoc
class __$ResultCopyWithImpl<$Res>
    implements _$ResultCopyWith<$Res> {
  __$ResultCopyWithImpl(this._self, this._then);

  final _Result _self;
  final $Res Function(_Result) _then;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? pageNumber = null,Object? pageSize = null,Object? totalRecords = null,}) {
  return _then(_Result(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<Datum>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalRecords: null == totalRecords ? _self.totalRecords : totalRecords // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Datum {

@JsonKey(name: "groupId") String get groupId;@JsonKey(name: "name") String get name;@JsonKey(name: "currency") String get currency;
/// Create a copy of Datum
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatumCopyWith<Datum> get copyWith => _$DatumCopyWithImpl<Datum>(this as Datum, _$identity);

  /// Serializes this Datum to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Datum&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,name,currency);

@override
String toString() {
  return 'Datum(groupId: $groupId, name: $name, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $DatumCopyWith<$Res>  {
  factory $DatumCopyWith(Datum value, $Res Function(Datum) _then) = _$DatumCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "groupId") String groupId,@JsonKey(name: "name") String name,@JsonKey(name: "currency") String currency
});




}
/// @nodoc
class _$DatumCopyWithImpl<$Res>
    implements $DatumCopyWith<$Res> {
  _$DatumCopyWithImpl(this._self, this._then);

  final Datum _self;
  final $Res Function(Datum) _then;

/// Create a copy of Datum
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupId = null,Object? name = null,Object? currency = null,}) {
  return _then(_self.copyWith(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Datum].
extension DatumPatterns on Datum {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Datum value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Datum() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Datum value)  $default,){
final _that = this;
switch (_that) {
case _Datum():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Datum value)?  $default,){
final _that = this;
switch (_that) {
case _Datum() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "groupId")  String groupId, @JsonKey(name: "name")  String name, @JsonKey(name: "currency")  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Datum() when $default != null:
return $default(_that.groupId,_that.name,_that.currency);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "groupId")  String groupId, @JsonKey(name: "name")  String name, @JsonKey(name: "currency")  String currency)  $default,) {final _that = this;
switch (_that) {
case _Datum():
return $default(_that.groupId,_that.name,_that.currency);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "groupId")  String groupId, @JsonKey(name: "name")  String name, @JsonKey(name: "currency")  String currency)?  $default,) {final _that = this;
switch (_that) {
case _Datum() when $default != null:
return $default(_that.groupId,_that.name,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Datum implements Datum {
  const _Datum({@JsonKey(name: "groupId") required this.groupId, @JsonKey(name: "name") required this.name, @JsonKey(name: "currency") required this.currency});
  factory _Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

@override@JsonKey(name: "groupId") final  String groupId;
@override@JsonKey(name: "name") final  String name;
@override@JsonKey(name: "currency") final  String currency;

/// Create a copy of Datum
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DatumCopyWith<_Datum> get copyWith => __$DatumCopyWithImpl<_Datum>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DatumToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Datum&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,name,currency);

@override
String toString() {
  return 'Datum(groupId: $groupId, name: $name, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$DatumCopyWith<$Res> implements $DatumCopyWith<$Res> {
  factory _$DatumCopyWith(_Datum value, $Res Function(_Datum) _then) = __$DatumCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "groupId") String groupId,@JsonKey(name: "name") String name,@JsonKey(name: "currency") String currency
});




}
/// @nodoc
class __$DatumCopyWithImpl<$Res>
    implements _$DatumCopyWith<$Res> {
  __$DatumCopyWithImpl(this._self, this._then);

  final _Datum _self;
  final $Res Function(_Datum) _then;

/// Create a copy of Datum
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? name = null,Object? currency = null,}) {
  return _then(_Datum(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
