class MoneyAccount {
  final int? id;
  final String name;
  final AccountType type;
  final DateTime lastUpdated;

  const MoneyAccount({
    this.id,
    required this.name,
    required this.type,
    required this.lastUpdated,
  });

  @override
  String toString() {
    return 'MoneyAccount(id: $id, name: $name, type: $type, lastUpdated: $lastUpdated)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  static MoneyAccount fromMap(Map<String, dynamic> map) {
    return MoneyAccount(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: AccountType.values[map['type'] as int],
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['lastUpdated'] as int),
    );
  }
}

enum AccountType {
  /// A bank account that is used for day-to-day spending
  checking,

  /// A bank account that is used for long-term savings
  savings,

  /// Other type of account, such as a credit card or loan
  other
}
