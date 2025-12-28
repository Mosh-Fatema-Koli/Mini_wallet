
import '../../domain/entities/transitation_entetis.dart';

class TransactionModel extends TransactionEntities {
  TransactionModel({
    required int id,
    required String merchantName,
    required double amount,
    required String discription,
    required String status,
  }) : super(id: id, merchantName: merchantName, amount: amount,discription: discription, status: status);

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      merchantName: "Merchant ${json['id']}", // Dummy merchant name
      amount: (json['id'] * 10).toDouble(),
      discription: json['body'], //body// Dummy amount
      status: 'Pending',
    );
  }
}
