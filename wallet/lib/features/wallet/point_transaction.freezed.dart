// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PointTransaction _$PointTransactionFromJson(Map<String, dynamic> json) {
  return _PointTransaction.fromJson(json);
}

/// @nodoc
mixin _$PointTransaction {
  String get transactionId => throw _privateConstructorUsedError;
  String get member => throw _privateConstructorUsedError;
  String get partner => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PointTransactionCopyWith<PointTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointTransactionCopyWith<$Res> {
  factory $PointTransactionCopyWith(
          PointTransaction value, $Res Function(PointTransaction) then) =
      _$PointTransactionCopyWithImpl<$Res, PointTransaction>;
  @useResult
  $Res call(
      {String transactionId,
      String member,
      String partner,
      String type,
      int points,
      DateTime timestamp});
}

/// @nodoc
class _$PointTransactionCopyWithImpl<$Res, $Val extends PointTransaction>
    implements $PointTransactionCopyWith<$Res> {
  _$PointTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? member = null,
    Object? partner = null,
    Object? type = null,
    Object? points = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      member: null == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as String,
      partner: null == partner
          ? _value.partner
          : partner // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PointTransactionCopyWith<$Res>
    implements $PointTransactionCopyWith<$Res> {
  factory _$$_PointTransactionCopyWith(
          _$_PointTransaction value, $Res Function(_$_PointTransaction) then) =
      __$$_PointTransactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionId,
      String member,
      String partner,
      String type,
      int points,
      DateTime timestamp});
}

/// @nodoc
class __$$_PointTransactionCopyWithImpl<$Res>
    extends _$PointTransactionCopyWithImpl<$Res, _$_PointTransaction>
    implements _$$_PointTransactionCopyWith<$Res> {
  __$$_PointTransactionCopyWithImpl(
      _$_PointTransaction _value, $Res Function(_$_PointTransaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? member = null,
    Object? partner = null,
    Object? type = null,
    Object? points = null,
    Object? timestamp = null,
  }) {
    return _then(_$_PointTransaction(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      member: null == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as String,
      partner: null == partner
          ? _value.partner
          : partner // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PointTransaction implements _PointTransaction {
  _$_PointTransaction(
      {required this.transactionId,
      required this.member,
      required this.partner,
      required this.type,
      required this.points,
      required this.timestamp});

  factory _$_PointTransaction.fromJson(Map<String, dynamic> json) =>
      _$$_PointTransactionFromJson(json);

  @override
  final String transactionId;
  @override
  final String member;
  @override
  final String partner;
  @override
  final String type;
  @override
  final int points;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'PointTransaction(transactionId: $transactionId, member: $member, partner: $partner, type: $type, points: $points, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PointTransaction &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.member, member) || other.member == member) &&
            (identical(other.partner, partner) || other.partner == partner) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, transactionId, member, partner, type, points, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PointTransactionCopyWith<_$_PointTransaction> get copyWith =>
      __$$_PointTransactionCopyWithImpl<_$_PointTransaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PointTransactionToJson(
      this,
    );
  }
}

abstract class _PointTransaction implements PointTransaction {
  factory _PointTransaction(
      {required final String transactionId,
      required final String member,
      required final String partner,
      required final String type,
      required final int points,
      required final DateTime timestamp}) = _$_PointTransaction;

  factory _PointTransaction.fromJson(Map<String, dynamic> json) =
      _$_PointTransaction.fromJson;

  @override
  String get transactionId;
  @override
  String get member;
  @override
  String get partner;
  @override
  String get type;
  @override
  int get points;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_PointTransactionCopyWith<_$_PointTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}
