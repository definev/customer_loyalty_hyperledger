import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_transaction.freezed.dart';
part 'point_transaction.g.dart';

@freezed
class PointTransaction with _$PointTransaction {
  factory PointTransaction({
    required String transactionId,
    required String member,
    required String partner,
    required String type,
    required int points,
    required DateTime timestamp,
  }) = _PointTransaction;

  factory PointTransaction.fromJson(Map<String, dynamic> json) => _$PointTransactionFromJson(json);
}
