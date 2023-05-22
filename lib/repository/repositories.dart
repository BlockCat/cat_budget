import 'package:cat_budget/services/budget/models.dart';

abstract class TransactionRepository {
  /// Get a transaction.
  /// returns the transaction
  Future<BankTransaction?> get(int id);

  /// Add a new transaction.
  /// returns the transaction with the id.
  Future<BankTransaction> insert(BankTransaction transaction);

  /// Delete an existing transaction.
  /// returns the number of rows deleted.
  Future<int> delete(int id);
}

abstract class AccountRepository {
  /// Get an account.
  /// returns the account
  Future<MoneyAccount?> get(int id);

  /// Add a new account.
  /// returns the account with the id.
  Future<MoneyAccount> insert(MoneyAccount account);

  /// Update an existing account.
  /// returns the account with the id.
  Future<MoneyAccount> update(MoneyAccount account);
}

abstract class CategoryRepository {
  /// Get a category.
  /// returns the category
  Future<Category?> get(int id);

  /// Add a new category.
  /// returns the category with the id.
  Future<Category> insert(Category category);

  /// Update an existing category.
  /// returns the category with the id.
  Future<Category> update(Category category);

  /// Delete an existing category.
  /// returns the number of rows deleted.
  Future<int> delete(Category category);

  /// Get the income category.
  Future<Category> getIncomeCategory();
}

abstract class CategoryEnvelopeRepository {
  /// Get a category envelope.
  /// returns the category envelope
  Future<CategoryEnvelope?> get(int id);

  Future<CategoryEnvelope?> getLastBeforePeriod(
      int categoryId, int year, int month);

  Future<CategoryEnvelope?> getPeriod(int categoryId, int year, int month);

  /// Add a new category envelope.
  /// returns the category envelope with the id.
  Future<CategoryEnvelope> insert(CategoryEnvelope envelope);

  /// Update an existing category envelope.
  /// returns the category envelope with the id.
  Future<CategoryEnvelope> update(CategoryEnvelope envelope);

  /// Upsert an existing category envelope.
  /// returns the category envelope with the id.
  Future<CategoryEnvelope> upsert(CategoryEnvelope envelope);

  /// Delete an existing category envelope.
  /// returns the number of rows deleted.
  Future<int> delete(CategoryEnvelope envelope);
}
