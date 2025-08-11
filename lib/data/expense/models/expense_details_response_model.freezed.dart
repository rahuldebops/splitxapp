// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_details_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseDetailsResponseModel {

 Result get result; String get message; dynamic get errorCode;
/// Create a copy of ExpenseDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseDetailsResponseModelCopyWith<ExpenseDetailsResponseModel> get copyWith => _$ExpenseDetailsResponseModelCopyWithImpl<ExpenseDetailsResponseModel>(this as ExpenseDetailsResponseModel, _$identity);

  /// Serializes this ExpenseDetailsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseDetailsResponseModel&&(identical(other.result, result) || other.result == result)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorCode, errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,message,const DeepCollectionEquality().hash(errorCode));

@override
String toString() {
  return 'ExpenseDetailsResponseModel(result: $result, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $ExpenseDetailsResponseModelCopyWith<$Res>  {
  factory $ExpenseDetailsResponseModelCopyWith(ExpenseDetailsResponseModel value, $Res Function(ExpenseDetailsResponseModel) _then) = _$ExpenseDetailsResponseModelCopyWithImpl;
@useResult
$Res call({
 Result result, String message, dynamic errorCode
});


$ResultCopyWith<$Res> get result;

}
/// @nodoc
class _$ExpenseDetailsResponseModelCopyWithImpl<$Res>
    implements $ExpenseDetailsResponseModelCopyWith<$Res> {
  _$ExpenseDetailsResponseModelCopyWithImpl(this._self, this._then);

  final ExpenseDetailsResponseModel _self;
  final $Res Function(ExpenseDetailsResponseModel) _then;

/// Create a copy of ExpenseDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? message = null,Object? errorCode = freezed,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of ExpenseDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res> get result {
  
  return $ResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExpenseDetailsResponseModel].
extension ExpenseDetailsResponseModelPatterns on ExpenseDetailsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseDetailsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseDetailsResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseDetailsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseDetailsResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseDetailsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseDetailsResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Result result,  String message,  dynamic errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseDetailsResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Result result,  String message,  dynamic errorCode)  $default,) {final _that = this;
switch (_that) {
case _ExpenseDetailsResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Result result,  String message,  dynamic errorCode)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseDetailsResponseModel() when $default != null:
return $default(_that.result,_that.message,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseDetailsResponseModel implements ExpenseDetailsResponseModel {
  const _ExpenseDetailsResponseModel({required this.result, required this.message, required this.errorCode});
  factory _ExpenseDetailsResponseModel.fromJson(Map<String, dynamic> json) => _$ExpenseDetailsResponseModelFromJson(json);

@override final  Result result;
@override final  String message;
@override final  dynamic errorCode;

/// Create a copy of ExpenseDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseDetailsResponseModelCopyWith<_ExpenseDetailsResponseModel> get copyWith => __$ExpenseDetailsResponseModelCopyWithImpl<_ExpenseDetailsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseDetailsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseDetailsResponseModel&&(identical(other.result, result) || other.result == result)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorCode, errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,message,const DeepCollectionEquality().hash(errorCode));

@override
String toString() {
  return 'ExpenseDetailsResponseModel(result: $result, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$ExpenseDetailsResponseModelCopyWith<$Res> implements $ExpenseDetailsResponseModelCopyWith<$Res> {
  factory _$ExpenseDetailsResponseModelCopyWith(_ExpenseDetailsResponseModel value, $Res Function(_ExpenseDetailsResponseModel) _then) = __$ExpenseDetailsResponseModelCopyWithImpl;
@override @useResult
$Res call({
 Result result, String message, dynamic errorCode
});


@override $ResultCopyWith<$Res> get result;

}
/// @nodoc
class __$ExpenseDetailsResponseModelCopyWithImpl<$Res>
    implements _$ExpenseDetailsResponseModelCopyWith<$Res> {
  __$ExpenseDetailsResponseModelCopyWithImpl(this._self, this._then);

  final _ExpenseDetailsResponseModel _self;
  final $Res Function(_ExpenseDetailsResponseModel) _then;

/// Create a copy of ExpenseDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? message = null,Object? errorCode = freezed,}) {
  return _then(_ExpenseDetailsResponseModel(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of ExpenseDetailsResponseModel
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

 List<Payment> get payments; List<Split> get splits; String get id; String get groupId; String get description; double get amount; String get createdAt;
/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultCopyWith<Result> get copyWith => _$ResultCopyWithImpl<Result>(this as Result, _$identity);

  /// Serializes this Result to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Result&&const DeepCollectionEquality().equals(other.payments, payments)&&const DeepCollectionEquality().equals(other.splits, splits)&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(payments),const DeepCollectionEquality().hash(splits),id,groupId,description,amount,createdAt);

@override
String toString() {
  return 'Result(payments: $payments, splits: $splits, id: $id, groupId: $groupId, description: $description, amount: $amount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ResultCopyWith<$Res>  {
  factory $ResultCopyWith(Result value, $Res Function(Result) _then) = _$ResultCopyWithImpl;
@useResult
$Res call({
 List<Payment> payments, List<Split> splits, String id, String groupId, String description, double amount, String createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? payments = null,Object? splits = null,Object? id = null,Object? groupId = null,Object? description = null,Object? amount = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,splits: null == splits ? _self.splits : splits // ignore: cast_nullable_to_non_nullable
as List<Split>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Payment> payments,  List<Split> splits,  String id,  String groupId,  String description,  double amount,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that.payments,_that.splits,_that.id,_that.groupId,_that.description,_that.amount,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Payment> payments,  List<Split> splits,  String id,  String groupId,  String description,  double amount,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _Result():
return $default(_that.payments,_that.splits,_that.id,_that.groupId,_that.description,_that.amount,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Payment> payments,  List<Split> splits,  String id,  String groupId,  String description,  double amount,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that.payments,_that.splits,_that.id,_that.groupId,_that.description,_that.amount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Result implements Result {
  const _Result({required final  List<Payment> payments, required final  List<Split> splits, required this.id, required this.groupId, required this.description, required this.amount, required this.createdAt}): _payments = payments,_splits = splits;
  factory _Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

 final  List<Payment> _payments;
@override List<Payment> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

 final  List<Split> _splits;
@override List<Split> get splits {
  if (_splits is EqualUnmodifiableListView) return _splits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_splits);
}

@override final  String id;
@override final  String groupId;
@override final  String description;
@override final  double amount;
@override final  String createdAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Result&&const DeepCollectionEquality().equals(other._payments, _payments)&&const DeepCollectionEquality().equals(other._splits, _splits)&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_payments),const DeepCollectionEquality().hash(_splits),id,groupId,description,amount,createdAt);

@override
String toString() {
  return 'Result(payments: $payments, splits: $splits, id: $id, groupId: $groupId, description: $description, amount: $amount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ResultCopyWith<$Res> implements $ResultCopyWith<$Res> {
  factory _$ResultCopyWith(_Result value, $Res Function(_Result) _then) = __$ResultCopyWithImpl;
@override @useResult
$Res call({
 List<Payment> payments, List<Split> splits, String id, String groupId, String description, double amount, String createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? payments = null,Object? splits = null,Object? id = null,Object? groupId = null,Object? description = null,Object? amount = null,Object? createdAt = null,}) {
  return _then(_Result(
payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,splits: null == splits ? _self._splits : splits // ignore: cast_nullable_to_non_nullable
as List<Split>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Payment {

 PaidBy get paidBy; double get amount;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paidBy,amount);

@override
String toString() {
  return 'Payment(paidBy: $paidBy, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 PaidBy paidBy, double amount
});


$PaidByCopyWith<$Res> get paidBy;

}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paidBy = null,Object? amount = null,}) {
  return _then(_self.copyWith(
paidBy: null == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as PaidBy,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaidByCopyWith<$Res> get paidBy {
  
  return $PaidByCopyWith<$Res>(_self.paidBy, (value) {
    return _then(_self.copyWith(paidBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaidBy paidBy,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.paidBy,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaidBy paidBy,  double amount)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.paidBy,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaidBy paidBy,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.paidBy,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payment implements Payment {
  const _Payment({required this.paidBy, required this.amount});
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

@override final  PaidBy paidBy;
@override final  double amount;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paidBy,amount);

@override
String toString() {
  return 'Payment(paidBy: $paidBy, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 PaidBy paidBy, double amount
});


@override $PaidByCopyWith<$Res> get paidBy;

}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paidBy = null,Object? amount = null,}) {
  return _then(_Payment(
paidBy: null == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as PaidBy,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaidByCopyWith<$Res> get paidBy {
  
  return $PaidByCopyWith<$Res>(_self.paidBy, (value) {
    return _then(_self.copyWith(paidBy: value));
  });
}
}


/// @nodoc
mixin _$PaidBy {

 String get id; String get fullName; String get phone; String get email;
/// Create a copy of PaidBy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaidByCopyWith<PaidBy> get copyWith => _$PaidByCopyWithImpl<PaidBy>(this as PaidBy, _$identity);

  /// Serializes this PaidBy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaidBy&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,phone,email);

@override
String toString() {
  return 'PaidBy(id: $id, fullName: $fullName, phone: $phone, email: $email)';
}


}

/// @nodoc
abstract mixin class $PaidByCopyWith<$Res>  {
  factory $PaidByCopyWith(PaidBy value, $Res Function(PaidBy) _then) = _$PaidByCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String phone, String email
});




}
/// @nodoc
class _$PaidByCopyWithImpl<$Res>
    implements $PaidByCopyWith<$Res> {
  _$PaidByCopyWithImpl(this._self, this._then);

  final PaidBy _self;
  final $Res Function(PaidBy) _then;

/// Create a copy of PaidBy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? phone = null,Object? email = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaidBy].
extension PaidByPatterns on PaidBy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaidBy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaidBy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaidBy value)  $default,){
final _that = this;
switch (_that) {
case _PaidBy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaidBy value)?  $default,){
final _that = this;
switch (_that) {
case _PaidBy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String phone,  String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaidBy() when $default != null:
return $default(_that.id,_that.fullName,_that.phone,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String phone,  String email)  $default,) {final _that = this;
switch (_that) {
case _PaidBy():
return $default(_that.id,_that.fullName,_that.phone,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String phone,  String email)?  $default,) {final _that = this;
switch (_that) {
case _PaidBy() when $default != null:
return $default(_that.id,_that.fullName,_that.phone,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaidBy implements PaidBy {
  const _PaidBy({required this.id, required this.fullName, required this.phone, required this.email});
  factory _PaidBy.fromJson(Map<String, dynamic> json) => _$PaidByFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String phone;
@override final  String email;

/// Create a copy of PaidBy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaidByCopyWith<_PaidBy> get copyWith => __$PaidByCopyWithImpl<_PaidBy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaidByToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaidBy&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,phone,email);

@override
String toString() {
  return 'PaidBy(id: $id, fullName: $fullName, phone: $phone, email: $email)';
}


}

/// @nodoc
abstract mixin class _$PaidByCopyWith<$Res> implements $PaidByCopyWith<$Res> {
  factory _$PaidByCopyWith(_PaidBy value, $Res Function(_PaidBy) _then) = __$PaidByCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String phone, String email
});




}
/// @nodoc
class __$PaidByCopyWithImpl<$Res>
    implements _$PaidByCopyWith<$Res> {
  __$PaidByCopyWithImpl(this._self, this._then);

  final _PaidBy _self;
  final $Res Function(_PaidBy) _then;

/// Create a copy of PaidBy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? phone = null,Object? email = null,}) {
  return _then(_PaidBy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Split {

 PaidBy get user; double get owedAmount;
/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitCopyWith<Split> get copyWith => _$SplitCopyWithImpl<Split>(this as Split, _$identity);

  /// Serializes this Split to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Split&&(identical(other.user, user) || other.user == user)&&(identical(other.owedAmount, owedAmount) || other.owedAmount == owedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,owedAmount);

@override
String toString() {
  return 'Split(user: $user, owedAmount: $owedAmount)';
}


}

/// @nodoc
abstract mixin class $SplitCopyWith<$Res>  {
  factory $SplitCopyWith(Split value, $Res Function(Split) _then) = _$SplitCopyWithImpl;
@useResult
$Res call({
 PaidBy user, double owedAmount
});


$PaidByCopyWith<$Res> get user;

}
/// @nodoc
class _$SplitCopyWithImpl<$Res>
    implements $SplitCopyWith<$Res> {
  _$SplitCopyWithImpl(this._self, this._then);

  final Split _self;
  final $Res Function(Split) _then;

/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? owedAmount = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PaidBy,owedAmount: null == owedAmount ? _self.owedAmount : owedAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaidByCopyWith<$Res> get user {
  
  return $PaidByCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [Split].
extension SplitPatterns on Split {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Split value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Split() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Split value)  $default,){
final _that = this;
switch (_that) {
case _Split():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Split value)?  $default,){
final _that = this;
switch (_that) {
case _Split() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaidBy user,  double owedAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Split() when $default != null:
return $default(_that.user,_that.owedAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaidBy user,  double owedAmount)  $default,) {final _that = this;
switch (_that) {
case _Split():
return $default(_that.user,_that.owedAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaidBy user,  double owedAmount)?  $default,) {final _that = this;
switch (_that) {
case _Split() when $default != null:
return $default(_that.user,_that.owedAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Split implements Split {
  const _Split({required this.user, required this.owedAmount});
  factory _Split.fromJson(Map<String, dynamic> json) => _$SplitFromJson(json);

@override final  PaidBy user;
@override final  double owedAmount;

/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplitCopyWith<_Split> get copyWith => __$SplitCopyWithImpl<_Split>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SplitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Split&&(identical(other.user, user) || other.user == user)&&(identical(other.owedAmount, owedAmount) || other.owedAmount == owedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,owedAmount);

@override
String toString() {
  return 'Split(user: $user, owedAmount: $owedAmount)';
}


}

/// @nodoc
abstract mixin class _$SplitCopyWith<$Res> implements $SplitCopyWith<$Res> {
  factory _$SplitCopyWith(_Split value, $Res Function(_Split) _then) = __$SplitCopyWithImpl;
@override @useResult
$Res call({
 PaidBy user, double owedAmount
});


@override $PaidByCopyWith<$Res> get user;

}
/// @nodoc
class __$SplitCopyWithImpl<$Res>
    implements _$SplitCopyWith<$Res> {
  __$SplitCopyWithImpl(this._self, this._then);

  final _Split _self;
  final $Res Function(_Split) _then;

/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? owedAmount = null,}) {
  return _then(_Split(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PaidBy,owedAmount: null == owedAmount ? _self.owedAmount : owedAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaidByCopyWith<$Res> get user {
  
  return $PaidByCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
