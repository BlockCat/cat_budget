import 'package:cat_budget/services/budget/models.dart';

abstract class BankTransactionService {
  /// Get all transactions for a given account.
  /// If [category] is provided, only transactions for that category will be returned.
  /// If [startDate] is provided, only transactions after that date will be returned.
  /// If [endDate] is provided, only transactions before that date will be returned.
  /// If [startDate] and [endDate] are provided, only transactions between those dates will be returned.
  /// If [account] is null, all transactions for all accounts will be returned.
  Future<List<BankTransaction>> getTransactions(Account? account,
      Category? category, DateTime? startDate, DateTime? endDate);

  /// Get a single transaction by its [id].
  Future<BankTransaction> getTransaction(int id);

  /// Add a new transaction.
  Future<BankTransaction> addTransaction(BankTransaction transaction);

  /// Update an existing transaction.
  Future<BankTransaction> updateTransaction(BankTransaction transaction);

  /// Delete an existing transaction.
  Future<BankTransaction> deleteTransaction(int id);
}

abstract class AccountService {
  /// Get all accounts.
  Future<List<Account>> getAccounts();

  /// Get a single account by its [id].
  Future<Account> getAccount(int id);

  /// Add a new account.
  Future<Account> addAccount(Account account);

  /// Update an existing account.
  Future<Account> updateAccount(Account account);

  /// Close an existing account.
  Future<Account> closeAccount(int id);
}

abstract class CategoryService {
  /// Get all categories.
  Future<List<Category>> getCategories();

  /// Get a single category by its [id].
  Future<Category> getCategory(int id);

  /// Add a new category.
  Future<Category> addCategory(Category category);

  /// Update an existing category.
  Future<Category> updateCategory(Category category);

  /// Delete an existing category.
  Future<Category> deleteCategory(int id);
}

abstract class CategoryEnvelopeService {
  /// Get all envelopes for a given category.
  Future<List<CategoryEnvelope>> getEnvelopes(Category category);

  /// Get a single envelope by its [id].
  Future<CategoryEnvelope> getEnvelope(int id);

  /// Add a new envelope.
  Future<CategoryEnvelope> addEnvelope(CategoryEnvelope envelope);

  /// Update an existing envelope.
  Future<CategoryEnvelope> updateEnvelope(CategoryEnvelope envelope);

  /// Delete an existing envelope.
  Future<CategoryEnvelope> deleteEnvelope(int id);

  /// Add money to an existing envelope.
  /// If [amount] is negative, money will be removed from the envelope.
  Future<CategoryEnvelope> addEnvelopeAmount(
      CategoryEnvelope envelope, double amount);
}

/// tests
test1() async {
  final categoryService = CategoryService();
  final categoryEnvelopeService = CategoryEnvelopeService();
  final accountService = AccountService();
  final bankTransactionService = BankTransactionService();

  final categories = await categoryService.getCategories();
  for (final category in categories) {
    final envelopes = await categoryEnvelopeService.getEnvelopes(
        category, null, DateTime.now());
    final balance = envelopes.fold(
        0.0, (previousValue, element) => previousValue + element.balance);

    print('Category: ${category.name}: $balance');
  }
}
