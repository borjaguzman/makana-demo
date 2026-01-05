class Transaction {
  final String id;
  final TransactionType type;
  final int amount; // Coins ganados o gastados
  final String description;
  final DateTime date;
  final TransactionStatus status;
  final String? relatedGiftCardId; // Si es un canje

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
    this.status = TransactionStatus.completed,
    this.relatedGiftCardId,
  });
}

enum TransactionType {
  earned,   // Ganó coins
  spent,    // Gastó coins (canje)
}

enum TransactionStatus {
  completed,
  pending,
  failed,
}
