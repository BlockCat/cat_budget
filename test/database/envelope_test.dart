import 'package:cat_budget/data/database/database.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MainDatabase database;
  late int accountId;
  late int category1Id;
  late int category2Id;

  late int category1Envelope1Id;
  late int category1Envelope2Id;

  late int category2Envelope1Id;
  late int category2Envelope2Id;
  setUp(() async {
    database = MainDatabase();
    accountId = await database.accounts
        .insertOne(AccountsCompanion.insert(name: 'account_name', type: 0));
    category1Id = await database.categories
        .insertOne(CategoriesCompanion.insert(name: 'category_1'));
    category2Id = await database.categories
        .insertOne(CategoriesCompanion.insert(name: 'category_2'));
    category1Envelope1Id = await database.categoryEnvelopes.insertOne(
        CategoryEnvelopesCompanion.insert(
            categoryId: category1Id,
            period: DateTime.utc(2023, 10),
            budget: 90,
            balance: const Value(90)));
    category1Envelope2Id = await database.categoryEnvelopes.insertOne(
        CategoryEnvelopesCompanion.insert(
            categoryId: category1Id,
            period: DateTime.utc(2023, 11),
            budget: 90,
            balance: const Value(180.0)));
    category2Envelope1Id = await database.categoryEnvelopes.insertOne(
        CategoryEnvelopesCompanion.insert(
            categoryId: category2Id,
            period: DateTime.utc(2023, 10),
            budget: 40,
            balance: const Value(40.0)));
    category2Envelope2Id = await database.categoryEnvelopes.insertOne(
        CategoryEnvelopesCompanion.insert(
            categoryId: category2Id,
            period: DateTime.utc(2023, 11),
            budget: 0,
            balance: const Value(40.0)));
  });

  tearDown(() async {
    await database.close();
  });

  test('envelope balance is ok', () async {
    expect(
        (await (database.categoryEnvelopes.select()
                  ..where((tbl) => tbl.id.equals(category1Envelope1Id)))
                .getSingle())
            .balance,
        90.0);
    expect(
        (await (database.categoryEnvelopes.select()
                  ..where((tbl) => tbl.id.equals(category1Envelope2Id)))
                .getSingle())
            .balance,
        180.0);
    expect(
        (await (database.categoryEnvelopes.select()
                  ..where((tbl) => tbl.id.equals(category2Envelope1Id)))
                .getSingle())
            .balance,
        40.0);
    expect(
        (await (database.categoryEnvelopes.select()
                  ..where((tbl) => tbl.id.equals(category2Envelope2Id)))
                .getSingle())
            .balance,
        40.0);
  });

  test('envelope balance after transaction', () async {
    final envelope1BalanceStream = (database.categoryEnvelopes.select()
          ..where((tbl) => tbl.id.equals(category1Envelope1Id)))
        .watchSingle()
        .map((event) => event.balance);

    final envelope1Balance =
        expectLater(envelope1BalanceStream, emitsInOrder([90, 45, -45]));
    final envelope2Balance = expectLater(
        (database.categoryEnvelopes.select()
              ..where((tbl) => tbl.id.equals(category1Envelope2Id)))
            .watchSingle()
            .map((event) => event.balance),
        emitsInOrder([180, 135, 90]));

    var transactionId = await database.bankTransactions.insertOne(
        BankTransactionsCompanion.insert(
            accountId: accountId,
            amount: -45,
            date: DateTime.utc(2023, 10, 15)));

    var transaction2Id = await database.bankTransactions.insertOne(
        BankTransactionsCompanion.insert(
            accountId: accountId,
            amount: -90,
            date: DateTime.utc(2023, 10, 15)));

    await database.bankTransactionCategory.insertOne(
        BankTransactionCategoryCompanion.insert(
            bankTransactionId: transactionId,
            categoryId: category1Id,
            amount: -45));
    await database.bankTransactionCategory.insertOne(
        BankTransactionCategoryCompanion.insert(
            bankTransactionId: transaction2Id,
            categoryId: category1Id,
            amount: -90));
    await envelope1Balance;
    await envelope2Balance;
  });
}
