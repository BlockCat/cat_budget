class Transaction {
  final int? id;
  final int accountId;
  final int categoryId;
  final double amount;
  final DateTime date;
  final String description;

  const Transaction({
    this.id,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.description,
  });

  @override
  String toString() {
    return 'Transaction(id: $id, accountId: $accountId, categoryId: $categoryId, amount: $amount, date: $date, description: $description)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountId': accountId,
      'categoryId': categoryId,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'description': description,
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int?,
      accountId: map['accountId'] as int,
      categoryId: map['categoryId'] as int,
      amount: map['amount'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      description: map['description'] as String,
    );
  }
}
