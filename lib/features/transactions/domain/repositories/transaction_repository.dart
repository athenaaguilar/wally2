import 'package:wally2/features/transactions/data/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionModel>> getTransactionHistory(int walletId);
  Future<void> addTransaction(int amount, String transactionType);
}
