import 'package:equatable/equatable.dart';
import '../../../domain/entities/transitation_entities.dart';

abstract class TransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state when nothing is loaded yet
class TransactionInitial extends TransactionState {}

/// Loading state for fetching transactions or wallet
class TransactionLoading extends TransactionState {}

/// Loaded state with transactions
class TransactionLoaded extends TransactionState {
  final List<TransactionEntities> transactions;

  TransactionLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}



/// Wallet state with balance + transactions
class WalletState extends TransactionState {
  final double balance;
  final List<TransactionEntities> transactions;

  WalletState({required this.balance, required this.transactions});

  @override
  List<Object?> get props => [balance, transactions];
}

/// Error state
class TransactionError extends TransactionState {
  final String message;

  TransactionError({required this.message});

  @override
  List<Object?> get props => [message];
}
