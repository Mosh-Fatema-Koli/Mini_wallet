class TransactionEntities {
  final int id;
  final String merchantName;
  final double amount;
  final String discription;
   String status;

  TransactionEntities({
    required this.id,
    required this.merchantName,
    required this.amount,
    required this.discription,
    required this.status,
  });

  TransactionEntities copyWith({
    int? id,
    String? merchantName,
    double? amount,
    String? discription,
    String? status,
  }) {
    return TransactionEntities(
      id: id ?? this.id,
      merchantName: merchantName ?? this.merchantName,
      amount: amount ?? this.amount,
      discription: discription ?? this.discription,
      status: status ?? this.status,
    );
  }
}
