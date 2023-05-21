import 'package:cat_budget/models/transaction.dart';
import 'package:cat_budget/repository/transaction_repository.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class SqliteTransactionRepository extends TransactionRepository {
  final sqflite.Database _database;

  SqliteTransactionRepository(this._database);

  @override
  Future<int> deleteTransaction(int id) {
    return _database.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Transaction>> getAllTransactions() {
    return _database.query('transactions').then((value) =>
        value.map((e) => Transaction.fromMap(e)).toList(growable: false));
  }

  @override
  Future<Transaction?> getTransaction(int id) {
    return _database.query('transactions', where: 'id = ?', whereArgs: [
      id
    ]).then((value) => value.map((e) => Transaction.fromMap(e)).firstOrNull);
  }

  @override
  Future<List<Transaction>> getTransactionsByCategory(int categoryId) {
    return _database.query('transactions',
        where: 'category_id = ?',
        whereArgs: [
          categoryId
        ]).then((value) =>
        value.map((e) => Transaction.fromMap(e)).toList(growable: false));
  }

  @override
  Future<List<Transaction>> getTransactionsByCategoryBetweenDates(
      int categoryId, DateTime? startDate, DateTime? endDate) {
    return _database.query('transactions',
        where: 'category_id = ? AND date >= ? AND date <= ?',
        whereArgs: [
          categoryId,
          startDate?.millisecondsSinceEpoch,
          endDate?.millisecondsSinceEpoch
        ]).then((value) =>
        value.map((e) => Transaction.fromMap(e)).toList(growable: false));
  }

  @override
  Future<int> insertTransaction(Transaction transaction) {
    var map = transaction.toMap();
    map.remove('id');
    return _database.insert('transactions', map);
  }

  @override
  Future<int> updateTransaction(int id, Transaction transaction) {
    return _database.update('transactions', transaction.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }
}
