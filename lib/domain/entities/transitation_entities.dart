class TransactionEntities {
  final int id;
  final String merchantName;
  final double amount;
  final String type; // add / send
  final String description;
  final String? status; // nullable → can be updated later
  final DateTime? date; // nullable → can be updated later

  const TransactionEntities({
    required this.id,
    required this.merchantName,
    required this.amount,
    required this.type,
    required this.description,
    this.status,
    this.date,
  });

  TransactionEntities copyWith({
    int? id,
    String? merchantName,
    double? amount,
    String? type,
    String? description,
    String? status,
    DateTime? date,
  }) {
    return TransactionEntities(
      id: id ?? this.id,
      merchantName: merchantName ?? this.merchantName,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }
}
