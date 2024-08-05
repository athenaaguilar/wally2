abstract class TransactionEvent {
  const TransactionEvent();
}

class TransactionInitialEvent extends TransactionEvent {
  const TransactionInitialEvent();
}

class GetTransactionHistoryEvent extends TransactionEvent {
  const GetTransactionHistoryEvent(this.walletId);

  final int walletId;
}

class AddTransactionEvent extends TransactionEvent {
  const AddTransactionEvent(this.amount, this.transactionType);

  final int amount;
  final String transactionType;
}
