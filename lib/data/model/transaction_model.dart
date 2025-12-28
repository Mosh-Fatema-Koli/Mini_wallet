
import '../../domain/entities/transitation_entities.dart';

class TransactionModel extends TransactionEntities {
  TransactionModel({
    required int id,
    required String merchantName,
    required double amount,
    required String type,
    required String description,
    String? status,
    DateTime? date,
  }) : super(
    id: id,
    merchantName: merchantName,
    amount: amount,
    type: type,
    description: description,
    status: status,
    date: date,
  );

  /// FROM API
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      merchantName: "Merchant ${json['id']}",
      amount: (json['id'] * 10).toDouble(),
      type: json['id'] % 2 == 0 ? 'add' : 'send',
      description: json['body'] ?? '',
      status: 'Pending',
      date: DateTime.now(),
    );
  }

  /// TO CACHE / LOCAL DB
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'merchantName': merchantName,
      'amount': amount,
      'type': type,
      'description': description,
      'status': status,
      'date': date?.toIso8601String(),
    };
  }
}
