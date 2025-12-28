
import '../entities/transitation_entetis.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntities>> getTransactions();
}
