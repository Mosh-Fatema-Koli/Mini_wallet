import '../../domain/entities/transitation_entities.dart';
import '../../domain/repositories/transition_repo.dart';
import '../data_sources/transitation_remote_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  List<TransactionEntities> _transactions = [];
  double _balance = 0;

  // -----------------------------
  // Fetch transactions from datasource
  // -----------------------------
  @override
  @override
  Future<List<TransactionEntities>> getTransactions() async {
    await Future.delayed(Duration(milliseconds: 500));
    if (_transactions.isEmpty) {
      final models = await remoteDataSource.fetchTransactions();
      _transactions = models.map((m) => TransactionEntities(
        id: m.id,
        merchantName: m.merchantName,
        amount: m.amount,
        type: m.type,
        description: m.description,
        status: m.status,
        date: m.date,
      )).toList();

      _recalculateBalance();
    }
    return _transactions;
  }

  // -----------------------------
  // Balance is sum of approved transactions
  // -----------------------------
  @override
  Future<double> getBalance() async {
    return _balance;
  }

  void _recalculateBalance() {
    _balance = 0;
    for (var t in _transactions) {
      if (t.status == 'Approved') {
        if (t.type == 'add') {
          _balance += t.amount;
        } else if (t.type == 'send') {
          _balance -= t.amount;
        }
      }
    }
  }

  // -----------------------------
  // Add money
  // -----------------------------
  @override
  Future<void> addMoney(double amount) async {
    final newTransaction = TransactionEntities(
      id: _transactions.length + 1,
      merchantName: 'Self Add',
      amount: amount,
      type: 'add',
      description: 'Added money to wallet',
      status: 'Approved',
      date: DateTime.now(),
    );
    _transactions.add(newTransaction);
    _recalculateBalance();
  }

  // -----------------------------
  // Send money
  // -----------------------------
  @override
  Future<void> sendMoney(double amount) async {
    if (_balance < amount) {
      throw Exception("Insufficient Balance");
    }
    final newTransaction = TransactionEntities(
      id: _transactions.length + 1,
      merchantName: 'Sent Money',
      amount: amount,
      type: 'send',
      description: 'Sent money',
      status: 'Approved',
      date: DateTime.now(),
    );
    _transactions.add(newTransaction);
    _recalculateBalance();
  }

  // -----------------------------
  // Update transaction status
  // -----------------------------

}
