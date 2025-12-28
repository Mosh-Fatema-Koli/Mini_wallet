
import '../entities/transitation_entities.dart';

abstract class TransactionRepository {

  Future<double> getBalance();
  Future<void> addMoney(double amount);
  Future<void> sendMoney(double amount);
  Future<List<TransactionEntities>> getTransactions();

}
