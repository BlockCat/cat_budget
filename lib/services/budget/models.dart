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
  final int? id;
  final String name;
  final String? description;

  Budget(this.id, this.name, this.description);
}

class BankTransaction {
  final int? id;
  final int accountId;
  final int? categoryId;
  final DateTime date;
  final String description;
  final double amount;

  BankTransaction(this.id, this.accountId, this.categoryId, this.date,
      this.description, this.amount);
}

class CategoryEnvelope {
  final int? id;
  final int categoryId;
  final double amountPutIn;
  final double balance;

  final int month;
  final int year;

  CategoryEnvelope(this.id, this.categoryId, this.year, this.month,
      this.amountPutIn, this.balance);
}

class MoneyAccount {
  final int? id;
  final String name;
  final String description;
  final double balance;

  MoneyAccount(this.id, this.name, this.description, this.balance);
}

class Category {
  final int? id;
  final String name;
  final String description;

  Category(this.id, this.name, this.description);
}
