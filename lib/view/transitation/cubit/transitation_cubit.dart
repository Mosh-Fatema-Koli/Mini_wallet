import 'package:boilerplate_of_cubit/view/transitation/cubit/transitation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/transitation_entetis.dart';
import '../../../domain/repositories/transition_repo.dart';


class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository repository;

  TransactionCubit({required this.repository}) : super(TransactionInitial());

  List<TransactionEntities> _allTransactions = [];

  Future<void> fetchTransactions() async {
    emit(TransactionLoading());
    try {
      _allTransactions = await repository.getTransactions();
      emit(TransactionLoaded(_allTransactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  void searchTransactions(String query) {
    final filtered = _allTransactions
        .where((t) => t.merchantName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(TransactionLoaded(filtered));
  }

// transaction_cubit.dart
  void updateStatus(int transactionId, String newStatus) {
    // Update the internal list
    _allTransactions = _allTransactions.map((t) {
      if (t.id == transactionId) {
        return t.copyWith(status: newStatus); // create new object with updated status
      }
      return t;
    }).toList();


    emit(TransactionLoaded(_allTransactions));
  }
}
