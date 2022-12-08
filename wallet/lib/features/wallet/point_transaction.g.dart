// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PointTransaction _$$_PointTransactionFromJson(Map<String, dynamic> json) =>
    _$_PointTransaction(
      transactionId: json['transactionId'] as String,
      member: json['member'] as String,
      partner: json['partner'] as String,
      type: json['type'] as String,
      points: json['points'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$_PointTransactionToJson(_$_PointTransaction instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'member': instance.member,
      'partner': instance.partner,
      'type': instance.type,
      'points': instance.points,
      'timestamp': instance.timestamp.toIso8601String(),
    };
