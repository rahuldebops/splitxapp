// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_update_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseUpdateRequestModel {

 String get expenseId; String get groupId; String get description; int get amount; List<Payment> get payments; List<Split> get splits;
/// Create a copy of ExpenseUpdateRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseUpdateRequestModelCopyWith<ExpenseUpdateRequestModel> get copyWith => _$ExpenseUpdateRequestModelCopyWithImpl<ExpenseUpdateRequestModel>(this as ExpenseUpdateRequestModel, _$identity);

  /// Serializes this ExpenseUpdateRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseUpdateRequestModel&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other.payments, payments)&&const DeepCollectionEquality().equals(other.splits, splits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expenseId,groupId,description,amount,const DeepCollectionEquality().hash(payments),const DeepCollectionEquality().hash(splits));

@override
String toString() {
  return 'ExpenseUpdateRequestModel(expenseId: $expenseId, groupId: $groupId, description: $description, amount: $amount, payments: $payments, splits: $splits)';
}


}

/// @nodoc
abstract mixin class $ExpenseUpdateRequestModelCopyWith<$Res>  {
  factory $ExpenseUpdateRequestModelCopyWith(ExpenseUpdateRequestModel value, $Res Function(ExpenseUpdateRequestModel) _then) = _$ExpenseUpdateRequestModelCopyWithImpl;
@useResult
$Res call({
 String expenseId, String groupId, String description, int amount, List<Payment> payments, List<Split> splits
});




}
/// @nodoc
class _$ExpenseUpdateRequestModelCopyWithImpl<$Res>
    implements $ExpenseUpdateRequestModelCopyWith<$Res> {
  _$ExpenseUpdateRequestModelCopyWithImpl(this._self, this._then);

  final ExpenseUpdateRequestModel _self;
  final $Res Function(ExpenseUpdateRequestModel) _then;

/// Create a copy of ExpenseUpdateRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expenseId = null,Object? groupId = null,Object? description = null,Object? amount = null,Object? payments = null,Object? splits = null,}) {
  return _then(_self.copyWith(
expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,splits: null == splits ? _self.splits : splits // ignore: cast_nullable_to_non_nullable
as List<Split>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseUpdateRequestModel].
extension ExpenseUpdateRequestModelPatterns on ExpenseUpdateRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseUpdateRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseUpdateRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseUpdateRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseUpdateRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseUpdateRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseUpdateRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String expenseId,  String groupId,  String description,  int amount,  List<Payment> payments,  List<Split> splits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseUpdateRequestModel() when $default != null:
return $default(_that.expenseId,_that.groupId,_that.description,_that.amount,_that.payments,_that.splits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String expenseId,  String groupId,  String description,  int amount,  List<Payment> payments,  List<Split> splits)  $default,) {final _that = this;
switch (_that) {
case _ExpenseUpdateRequestModel():
return $default(_that.expenseId,_that.groupId,_that.description,_that.amount,_that.payments,_that.splits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String expenseId,  String groupId,  String description,  int amount,  List<Payment> payments,  List<Split> splits)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseUpdateRequestModel() when $default != null:
return $default(_that.expenseId,_that.groupId,_that.description,_that.amount,_that.payments,_that.splits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseUpdateRequestModel implements ExpenseUpdateRequestModel {
  const _ExpenseUpdateRequestModel({required this.expenseId, required this.groupId, required this.description, required this.amount, required final  List<Payment> payments, required final  List<Split> splits}): _payments = payments,_splits = splits;
  factory _ExpenseUpdateRequestModel.fromJson(Map<String, dynamic> json) => _$ExpenseUpdateRequestModelFromJson(json);

@override final  String expenseId;
@override final  String groupId;
@override final  String description;
@override final  int amount;
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


/// Create a copy of ExpenseUpdateRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseUpdateRequestModelCopyWith<_ExpenseUpdateRequestModel> get copyWith => __$ExpenseUpdateRequestModelCopyWithImpl<_ExpenseUpdateRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseUpdateRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseUpdateRequestModel&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other._payments, _payments)&&const DeepCollectionEquality().equals(other._splits, _splits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expenseId,groupId,description,amount,const DeepCollectionEquality().hash(_payments),const DeepCollectionEquality().hash(_splits));

@override
String toString() {
  return 'ExpenseUpdateRequestModel(expenseId: $expenseId, groupId: $groupId, description: $description, amount: $amount, payments: $payments, splits: $splits)';
}


}

/// @nodoc
abstract mixin class _$ExpenseUpdateRequestModelCopyWith<$Res> implements $ExpenseUpdateRequestModelCopyWith<$Res> {
  factory _$ExpenseUpdateRequestModelCopyWith(_ExpenseUpdateRequestModel value, $Res Function(_ExpenseUpdateRequestModel) _then) = __$ExpenseUpdateRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String expenseId, String groupId, String description, int amount, List<Payment> payments, List<Split> splits
});




}
/// @nodoc
class __$ExpenseUpdateRequestModelCopyWithImpl<$Res>
    implements _$ExpenseUpdateRequestModelCopyWith<$Res> {
  __$ExpenseUpdateRequestModelCopyWithImpl(this._self, this._then);

  final _ExpenseUpdateRequestModel _self;
  final $Res Function(_ExpenseUpdateRequestModel) _then;

/// Create a copy of ExpenseUpdateRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expenseId = null,Object? groupId = null,Object? description = null,Object? amount = null,Object? payments = null,Object? splits = null,}) {
  return _then(_ExpenseUpdateRequestModel(
expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,splits: null == splits ? _self._splits : splits // ignore: cast_nullable_to_non_nullable
as List<Split>,
  ));
}


}


/// @nodoc
mixin _$Payment {

 String get paidBy; int get amount;
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
 String paidBy, int amount
});




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
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paidBy,  int amount)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paidBy,  int amount)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paidBy,  int amount)?  $default,) {final _that = this;
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

@override final  String paidBy;
@override final  int amount;

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
 String paidBy, int amount
});




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
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Split {

 String get userId; int get owedAmount;
/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitCopyWith<Split> get copyWith => _$SplitCopyWithImpl<Split>(this as Split, _$identity);

  /// Serializes this Split to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Split&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.owedAmount, owedAmount) || other.owedAmount == owedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,owedAmount);

@override
String toString() {
  return 'Split(userId: $userId, owedAmount: $owedAmount)';
}


}

/// @nodoc
abstract mixin class $SplitCopyWith<$Res>  {
  factory $SplitCopyWith(Split value, $Res Function(Split) _then) = _$SplitCopyWithImpl;
@useResult
$Res call({
 String userId, int owedAmount
});




}
/// @nodoc
class _$SplitCopyWithImpl<$Res>
    implements $SplitCopyWith<$Res> {
  _$SplitCopyWithImpl(this._self, this._then);

  final Split _self;
  final $Res Function(Split) _then;

/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? owedAmount = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,owedAmount: null == owedAmount ? _self.owedAmount : owedAmount // ignore: cast_nullable_to_non_nullable
as int,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int owedAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Split() when $default != null:
return $default(_that.userId,_that.owedAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int owedAmount)  $default,) {final _that = this;
switch (_that) {
case _Split():
return $default(_that.userId,_that.owedAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int owedAmount)?  $default,) {final _that = this;
switch (_that) {
case _Split() when $default != null:
return $default(_that.userId,_that.owedAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Split implements Split {
  const _Split({required this.userId, required this.owedAmount});
  factory _Split.fromJson(Map<String, dynamic> json) => _$SplitFromJson(json);

@override final  String userId;
@override final  int owedAmount;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Split&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.owedAmount, owedAmount) || other.owedAmount == owedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,owedAmount);

@override
String toString() {
  return 'Split(userId: $userId, owedAmount: $owedAmount)';
}


}

/// @nodoc
abstract mixin class _$SplitCopyWith<$Res> implements $SplitCopyWith<$Res> {
  factory _$SplitCopyWith(_Split value, $Res Function(_Split) _then) = __$SplitCopyWithImpl;
@override @useResult
$Res call({
 String userId, int owedAmount
});




}
/// @nodoc
class __$SplitCopyWithImpl<$Res>
    implements _$SplitCopyWith<$Res> {
  __$SplitCopyWithImpl(this._self, this._then);

  final _Split _self;
  final $Res Function(_Split) _then;

/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? owedAmount = null,}) {
  return _then(_Split(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,owedAmount: null == owedAmount ? _self.owedAmount : owedAmount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
