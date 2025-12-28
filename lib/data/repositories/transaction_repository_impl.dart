

import '../../domain/entities/transitation_entetis.dart';
import '../../domain/repositories/transition_repo.dart';
import '../data_sources/transitation_remote_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TransactionEntities>> getTransactions() async {
    return await remoteDataSource.fetchTransactions();
  }
}
