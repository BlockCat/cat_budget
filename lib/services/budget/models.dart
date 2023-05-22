/// Budget Service provides all the functionality needed to manage budgets.
/// This includes creating, updating, deleting, and retrieving budgets.
/// It also provides the ability to retrieve budget categories and budget items.
/// Features:
/// * Budgets
/// * Budget Categories
/// * Budget Envelopes per month
/// * Transactions are all grouped in a month
///
/// Budgets are the top level of the budgeting system. They are the highest level
/// of organization and are used to group budget categories together.
class Budget {
  /// The unique identifier for the budget.
  final int id;

  /// The name of the budget.
  final String name;

  /// The description of the budget.
  final String? description;

  /// The date the budget was created.
  /// The list of categories for the budget.
  final List<Category> categories;

  /// The list of accounts for the budget.
  final List<Account> accounts;
}

class BankTransaction {
  final int id;
  final Category? category;
  final DateTime date;
  final String description;
  final double amount;
}

class CategoryEnvelope {
  final int id;
  final Category category;
  final double amount;
  final double balance;
}

class Account {
  final int id;
  final String name;
  final String description;
  final double balance;
  final List<BankTransaction> transactions;

  Account(
      this.id, this.name, this.description, this.balance, this.transactions);
}

class Category {
  final int id;
  final String name;
  final String description;
  final List<CategoryEnvelope> envelopes;

  Category(this.id, this.name, this.description, this.envelopes);
}