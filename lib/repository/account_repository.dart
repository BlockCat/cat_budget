import 'package:cat_budget/models/account.dart';

abstract class AccountRepository {
  Future<List<MoneyAccount>> getAllAccounts();
  Future<MoneyAccount?> getAccount(int id);
  Future<int> insertAccount(MoneyAccount account);
  Future<int> updateAccount(int id, MoneyAccount account);
  Future<int> deleteAccount(int id);
}
