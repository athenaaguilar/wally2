class TransactionEntity {
  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.transactionType,
    required this.createdAt,
  });

  final int id;
  final int amount;
  final String transactionType;
  final DateTime createdAt;
}
