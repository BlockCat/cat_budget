import 'package:cat_budget/models/account.dart';
import 'package:cat_budget/repository/account_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqliteAccountRepository extends AccountRepository {
  SqliteAccountRepository(this._database);

  final Database _database;

  @override
  Future<int> deleteAccount(int id) async {
    return await _database.delete('accounts', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<MoneyAccount?> getAccount(int id) async {
    return _database.query('accounts', where: 'id = ?', whereArgs: [id]).then(
        (value) => value.map((e) => MoneyAccount.fromMap(e)).firstOrNull);
  }

  @override
  Future<List<MoneyAccount>> getAllAccounts() {
    return _database.query('accounts').then((value) =>
        value.map((e) => MoneyAccount.fromMap(e)).toList(growable: false));
  }

  @override
  Future<int> insertAccount(MoneyAccount account) {
    var map = account.toMap();
    map.remove('id');
    return _database.insert('accounts', map);
  }

  @override
  Future<int> updateAccount(int id, MoneyAccount account) {
    return _database
        .update('accounts', account.toMap(), where: 'id = ?', whereArgs: [id]);
  }
}
