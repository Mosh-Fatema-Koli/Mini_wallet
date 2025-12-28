import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/transaction_model.dart';
import '../../../domain/entities/transitation_entities.dart';
import '../../../domain/repositories/transition_repo.dart';
import 'transitation_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository repository;

  TransactionCubit({required this.repository}) : super(TransactionInitial());

  List<TransactionEntities> _allTransactions = [];

  // -----------------------------
  // PRIVATE: Calculate balance only for approved transactions
  // -----------------------------
  double _calculateBalance(List<TransactionEntities> list) {
    return list.fold<double>(0, (sum, t) {
      if (t.status != 'Approved') return sum;
      return t.type == 'send' ? sum - t.amount : sum + t.amount;
    });
  }

  // -----------------------------
  // FETCH TRANSACTIONS
  // -----------------------------
  Future<void> fetchTransactions() async {
    emit(TransactionLoading());
    try {
      _allTransactions = await repository.getTransactions();
      emit(TransactionLoaded(transactions: _allTransactions));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  // -----------------------------
  // SEARCH TRANSACTIONS
  // -----------------------------
  void searchTransactions(String query) {
    final filtered = _allTransactions
        .where((t) => t.merchantName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(TransactionLoaded(transactions: filtered));
  }

  // -----------------------------
  // UPDATE TRANSACTION STATUS
  // -----------------------------
  Future<void> updateTransactionStatus(int transactionId, String status) async {
    // 1️⃣ Find the transaction index
    final index = _allTransactions.indexWhere((t) => t.id == transactionId);
    if (index == -1) return; // not found

    // 2️⃣ Create updated transaction
    final updatedTransaction = _allTransactions[index].copyWith(
      status: status,
      date: DateTime.now(),
    );

    // 3️⃣ Update the list immutably
    _allTransactions = List.from(_allTransactions)
      ..[index] = updatedTransaction;

    // 4️⃣ Recalculate balance
    final balance = _calculateBalance(_allTransactions);

    // 5️⃣ Emit updated state
    emit(TransactionLoaded(transactions: _allTransactions));

  }


  // -----------------------------
  // WALLET METHODS
  // -----------------------------
  Future<void> loadWallet() async {
    emit(TransactionLoading());
    try {
      _allTransactions = await repository.getTransactions();
      final balance = _calculateBalance(_allTransactions);
      emit(WalletState(balance: balance, transactions: _allTransactions));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> addMoneyAction(double amount) async {
    try {
      await repository.addMoney(amount);
      await loadWallet(); // reload wallet after adding
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> sendMoneyAction(double amount) async {
    try {
      await repository.sendMoney(amount);
      await loadWallet(); // reload wallet after sending
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  // -----------------------------
  // OPTIONAL: Refresh all data (transactions + wallet)
  // -----------------------------
  Future<void> refresh() async {
    await loadWallet();
  }
}
