// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_update_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseUpdateResponseModel {

 bool get result; String get message; dynamic get errorCode;
/// Create a copy of ExpenseUpdateResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseUpdateResponseModelCopyWith<ExpenseUpdateResponseModel> get copyWith => _$ExpenseUpdateResponseModelCopyWithImpl<ExpenseUpdateResponseModel>(this as ExpenseUpdateResponseModel, _$identity);

  /// Serializes this ExpenseUpdateResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseUpdateResponseModel&&(identical(other.result, result) || other.result == result)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorCode, errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,message,const DeepCollectionEquality().hash(errorCode));

@override
String toString() {
  return 'ExpenseUpdateResponseModel(result: $result, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $ExpenseUpdateResponseModelCopyWith<$Res>  {
  factory $ExpenseUpdateResponseModelCopyWith(ExpenseUpdateResponseModel value, $Res Function(ExpenseUpdateResponseModel) _then) = _$ExpenseUpdateResponseModelCopyWithImpl;
@useResult
$Res call({
 bool result, String message, dynamic errorCode
});




}
/// @nodoc
class _$ExpenseUpdateResponseModelCopyWithImpl<$Res>
    implements $ExpenseUpdateResponseModelCopyWith<$Res> {
  _$ExpenseUpdateResponseModelCopyWithImpl(this._self, this._then);

  final ExpenseUpdateResponseModel _self;
  final $Res Function(ExpenseUpdateResponseModel) _then;

/// Create a copy of ExpenseUpdateResponseModel
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


/// Adds pattern-matching-related methods to [ExpenseUpdateResponseModel].
extension ExpenseUpdateResponseModelPatterns on ExpenseUpdateResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseUpdateResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseUpdateResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseUpdateResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseUpdateResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseUpdateResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseUpdateResponseModel() when $default != null:
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
case _ExpenseUpdateResponseModel() when $default != null:
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
case _ExpenseUpdateResponseModel():
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
case _ExpenseUpdateResponseModel() when $default != null:
return $default(_that.result,_that.message,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseUpdateResponseModel implements ExpenseUpdateResponseModel {
  const _ExpenseUpdateResponseModel({required this.result, required this.message, required this.errorCode});
  factory _ExpenseUpdateResponseModel.fromJson(Map<String, dynamic> json) => _$ExpenseUpdateResponseModelFromJson(json);

@override final  bool result;
@override final  String message;
@override final  dynamic errorCode;

/// Create a copy of ExpenseUpdateResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseUpdateResponseModelCopyWith<_ExpenseUpdateResponseModel> get copyWith => __$ExpenseUpdateResponseModelCopyWithImpl<_ExpenseUpdateResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseUpdateResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseUpdateResponseModel&&(identical(other.result, result) || other.result == result)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorCode, errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,message,const DeepCollectionEquality().hash(errorCode));

@override
String toString() {
  return 'ExpenseUpdateResponseModel(result: $result, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$ExpenseUpdateResponseModelCopyWith<$Res> implements $ExpenseUpdateResponseModelCopyWith<$Res> {
  factory _$ExpenseUpdateResponseModelCopyWith(_ExpenseUpdateResponseModel value, $Res Function(_ExpenseUpdateResponseModel) _then) = __$ExpenseUpdateResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool result, String message, dynamic errorCode
});




}
/// @nodoc
class __$ExpenseUpdateResponseModelCopyWithImpl<$Res>
    implements _$ExpenseUpdateResponseModelCopyWith<$Res> {
  __$ExpenseUpdateResponseModelCopyWithImpl(this._self, this._then);

  final _ExpenseUpdateResponseModel _self;
  final $Res Function(_ExpenseUpdateResponseModel) _then;

/// Create a copy of ExpenseUpdateResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? message = null,Object? errorCode = freezed,}) {
  return _then(_ExpenseUpdateResponseModel(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
