import 'package:cat_budget/repository/repositories.dart';
import 'package:cat_budget/services/budget/models.dart';

class BankTransactionService {
  final CategoryEnvelopeService _categoryEnvelopeService;
  final AccountService _accountService;
  final TransactionRepository _repository;

  BankTransactionService(
      this._categoryEnvelopeService, this._accountService, this._repository);

  /// Add a new transaction.
  Future<BankTransaction> addTransaction(BankTransaction transaction) async {
    /// Insert the transaction.
    transaction = await _repository.insert(transaction);

    /// Update the account balance.
    await _accountService.updateBalance(
        transaction.accountId, transaction.amount);

    if (transaction.categoryId != null) {
      final envelope = await _categoryEnvelopeService.getEnvelope(
          transaction.categoryId!,
          transaction.date.year,
          transaction.date.month);

      await _categoryEnvelopeService.addEnvelopeTransaction(
          envelope, transaction);
    }

    return transaction;
  }

  /// Update an existing transaction.
  Future<BankTransaction> updateTransaction(BankTransaction transaction) async {
    if (transaction.id == null) {
      return await addTransaction(transaction);
    }
    await deleteTransaction(transaction.id!);
    return await addTransaction(transaction);
  }

  /// Delete an existing transaction.
  Future<void> deleteTransaction(int id) async {
    final BankTransaction? transaction = await _repository.get(id);
    final deleted = await _repository.delete(id);
    if (transaction == null) {
      assert(deleted == 0, 'Deleted transaction that does not exist?');
      return;
    }

    /// Update the account balance.
    await _accountService.updateBalance(
        transaction.accountId, -transaction.amount);

    if (transaction.categoryId != null) {
      final envelope = await _categoryEnvelopeService.getEnvelope(
          transaction.categoryId!,
          transaction.date.year,
          transaction.date.month);

      await _categoryEnvelopeService.removeEnvelopeTransaction(
          envelope, transaction);
    }
  }
}

class AccountService {
  final AccountRepository _repository;
  final BankTransactionService _transactionService;
  final CategoryService _categoryService;

  AccountService(
      this._repository, this._transactionService, this._categoryService);

  /// Add a new account.
  Future<MoneyAccount> openAccount(MoneyAccount account) async {
    account = await _repository.insert(account);
    final incomeCategory = await _categoryService.getIncomeCategory();
    await _transactionService.addTransaction(BankTransaction(
      null,
      account.id!,
      incomeCategory.id!,
      DateTime.now(),
      'Initial Balance transaction',
      account.balance,
    ));
    return account;
  }

  /// Update an existing account.
  Future<MoneyAccount> updateAccount(MoneyAccount account) {
    return _repository.update(account);
  }

  Future<MoneyAccount> updateBalance(int accountId, double amount) async {
    final MoneyAccount? account = await _repository.get(accountId);
    assert(account != null, 'Account does not exist');

    final nextAccount = MoneyAccount(accountId, account!.name,
        account.description, account.balance + amount);

    return _repository.update(nextAccount);
  }

  /// Close an existing account.
  // Future<Account> closeAccount(int id);
}

class CategoryService {
  final CategoryRepository _repository;

  CategoryService(this._repository);

  /// Add a new category.
  Future<Category> addCategory(Category category) async {
    return _repository.insert(category);
  }

  /// Update an existing category.
  Future<Category> updateCategory(Category category) async {
    return _repository.update(category);
  }

  /// Delete an existing category.
  Future<int> deleteCategory(Category category) async {
    return _repository.delete(category);
  }

  Future<Category> getIncomeCategory() {
    return _repository.getIncomeCategory();
  }
}

class CategoryEnvelopeService {
  final CategoryEnvelopeRepository _repository;

  CategoryEnvelopeService(this._repository);

  /// Get an envelope for a given category and period.
  /// If no envelope exists, a default will be created but not persisted.
  Future<CategoryEnvelope> getEnvelope(
      int categoryId, int year, int month) async {
    /// Get the envelope from the repository.
    final previousEnvelope =
        await _repository.getLastBeforePeriod(categoryId, year, month);

    final currentEnvelope =
        await _repository.getPeriod(categoryId, year, month);

    return CategoryEnvelope(
      currentEnvelope?.id,
      categoryId,
      year,
      month,
      currentEnvelope?.amountPutIn ?? 0,
      (currentEnvelope?.balance ?? 0) + (previousEnvelope?.balance ?? 0),
    );
  }

  /// Add money to an existing envelope.
  /// If [amount] is negative, money will be removed from the envelope.
  /// Also persists the envelope.
  Future<CategoryEnvelope> addEnvelopeAmount(
      CategoryEnvelope envelope, double amount) async {
    final nextEnvelope = CategoryEnvelope(
      envelope.id,
      envelope.categoryId,
      envelope.year,
      envelope.month,
      envelope.amountPutIn + amount,
      envelope.balance + amount,
    );
    await _repository.upsert(nextEnvelope);

    return nextEnvelope;
  }

  Future<CategoryEnvelope> addEnvelopeTransaction(
      CategoryEnvelope envelope, BankTransaction transaction) async {
    assert(transaction.categoryId != null, 'Transaction must have a category');
    assert(transaction.categoryId == envelope.categoryId,
        'Transaction category must match envelope category');
    final nextEnvelope = CategoryEnvelope(
      envelope.id,
      envelope.categoryId,
      envelope.year,
      envelope.month,
      envelope.amountPutIn,
      envelope.balance + transaction.amount,
    );
    await _repository.upsert(nextEnvelope);

    return nextEnvelope;
  }

  Future<CategoryEnvelope> removeEnvelopeTransaction(
      CategoryEnvelope envelope, BankTransaction transaction) async {
    assert(transaction.categoryId != null, 'Transaction must have a category');
    assert(transaction.categoryId == envelope.categoryId,
        'Transaction category must match envelope category');
    final nextEnvelope = CategoryEnvelope(
      envelope.id,
      envelope.categoryId,
      envelope.year,
      envelope.month,
      envelope.amountPutIn,
      envelope.balance - transaction.amount,
    );
    await _repository.upsert(nextEnvelope);

    return nextEnvelope;
  }
}
