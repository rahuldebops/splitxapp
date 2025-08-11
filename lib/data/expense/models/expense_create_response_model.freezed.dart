// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_create_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseCreateResponseModel {

 bool get result; String get message; dynamic get errorCode;
/// Create a copy of ExpenseCreateResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseCreateResponseModelCopyWith<ExpenseCreateResponseModel> get copyWith => _$ExpenseCreateResponseModelCopyWithImpl<ExpenseCreateResponseModel>(this as ExpenseCreateResponseModel, _$identity);

  /// Serializes this ExpenseCreateResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseCreateResponseModel&&(identical(other.result, result) || other.result == result)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorCode, errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,message,const DeepCollectionEquality().hash(errorCode));

@override
String toString() {
  return 'ExpenseCreateResponseModel(result: $result, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $ExpenseCreateResponseModelCopyWith<$Res>  {
  factory $ExpenseCreateResponseModelCopyWith(ExpenseCreateResponseModel value, $Res Function(ExpenseCreateResponseModel) _then) = _$ExpenseCreateResponseModelCopyWithImpl;
@useResult
$Res call({
 bool result, String message, dynamic errorCode
});




}
/// @nodoc
class _$ExpenseCreateResponseModelCopyWithImpl<$Res>
    implements $ExpenseCreateResponseModelCopyWith<$Res> {
  _$ExpenseCreateResponseModelCopyWithImpl(this._self, this._then);

  final ExpenseCreateResponseModel _self;
  final $Res Function(ExpenseCreateResponseModel) _then;

/// Create a copy of ExpenseCreateResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? message = null,Object? errorCode = freezed,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseCreateResponseModel].
extension ExpenseCreateResponseModelPatterns on ExpenseCreateResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseCreateResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseCreateResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseCreateResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseCreateResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseCreateResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseCreateResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool result,  String message,  dynamic errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseCreateResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool result,  String message,  dynamic errorCode)  $default,) {final _that = this;
switch (_that) {
case _ExpenseCreateResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool result,  String message,  dynamic errorCode)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseCreateResponseModel() when $default != null:
return $default(_that.result,_that.message,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseCreateResponseModel implements ExpenseCreateResponseModel {
  const _ExpenseCreateResponseModel({required this.result, required this.message, required this.errorCode});
  factory _ExpenseCreateResponseModel.fromJson(Map<String, dynamic> json) => _$ExpenseCreateResponseModelFromJson(json);

@override final  bool result;
@override final  String message;
@override final  dynamic errorCode;

/// Create a copy of ExpenseCreateResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseCreateResponseModelCopyWith<_ExpenseCreateResponseModel> get copyWith => __$ExpenseCreateResponseModelCopyWithImpl<_ExpenseCreateResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseCreateResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseCreateResponseModel&&(identical(other.result, result) || other.result == result)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorCode, errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,message,const DeepCollectionEquality().hash(errorCode));

@override
String toString() {
  return 'ExpenseCreateResponseModel(result: $result, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$ExpenseCreateResponseModelCopyWith<$Res> implements $ExpenseCreateResponseModelCopyWith<$Res> {
  factory _$ExpenseCreateResponseModelCopyWith(_ExpenseCreateResponseModel value, $Res Function(_ExpenseCreateResponseModel) _then) = __$ExpenseCreateResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool result, String message, dynamic errorCode
});




}
/// @nodoc
class __$ExpenseCreateResponseModelCopyWithImpl<$Res>
    implements _$ExpenseCreateResponseModelCopyWith<$Res> {
  __$ExpenseCreateResponseModelCopyWithImpl(this._self, this._then);

  final _ExpenseCreateResponseModel _self;
  final $Res Function(_ExpenseCreateResponseModel) _then;

/// Create a copy of ExpenseCreateResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? message = null,Object? errorCode = freezed,}) {
  return _then(_ExpenseCreateResponseModel(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
