import 'package:wally2/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionState {
  const TransactionState();
}

class TransactionInitialState extends TransactionState {
  const TransactionInitialState();
}

class TransactionLoadingState extends TransactionState {
  const TransactionLoadingState();
}

class GetTransactionHistorySuccessState extends TransactionState {
  const GetTransactionHistorySuccessState({required this.transactionHistory});

  final List<TransactionEntity> transactionHistory;
}

class GetTransactionHistoryFailedState extends TransactionState {
  const GetTransactionHistoryFailedState();
}

class AddTransactionSuccessState extends TransactionState {
  const AddTransactionSuccessState();
}

class AddTransactionFailedState extends TransactionState {
  const AddTransactionFailedState();
}
