import 'package:get_it/get_it.dart';

import '../data/data_sources/transitation_remote_datasource.dart';
import '../data/repositories/transaction_repository_impl.dart';
import '../domain/repositories/transition_repo.dart';
import '../view/transitation/cubit/transitation_cubit.dart';


final sl = GetIt.instance; // Service Locator

Future<void> init() async {
  // -----------------------------
  // Cubits / Bloc
  // -----------------------------
  sl.registerFactory(() => TransactionCubit(repository: sl()));

  // -----------------------------
  // Repositories
  // -----------------------------
  sl.registerLazySingleton<TransactionRepository>(
          () => TransactionRepositoryImpl(remoteDataSource: sl()));

  // -----------------------------
  // Data Sources
  // -----------------------------
  sl.registerLazySingleton<TransactionRemoteDataSource>(
          () => TransactionRemoteDataSourceImpl());
}
