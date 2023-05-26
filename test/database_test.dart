import 'package:cat_budget/data/database/database.dart';
import 'package:drift/drift.dart';
import 'package:test/test.dart';

void main() {
  late MainDatabase database;
  setUp(() {
    database = MainDatabase();
  });

  tearDown(() async {
    await database.close();
  });

  test('can insert account', () async {
    final builder = AccountsCompanion.insert(
        name: "name",
        type: 0,
        description: const Value("description"),
        balance: const Value(1000));

    await database.accounts.insertOne(builder);

    final expectAccountBalance = expectLater(
        database.moneyInBank().watchSingle(), emitsInOrder([1000, 2000, 3000]));

    final id = await database.accounts.insertOne(AccountsCompanion.insert(
        name: "name2", type: 0, balance: const Value(1000)));

    await (database.update(database.accounts)
          ..where((tbl) => tbl.id.equals(id)))
        .write(const AccountsCompanion(balance: Value(2000)));

    expect(await database.moneyInBank().getSingle(), 3000);
    await expectAccountBalance;
  });

  test('account updates after transactions', () async {
    final builder = AccountsCompanion.insert(
        name: "name",
        type: 0,
        description: const Value("description"),
        balance: const Value(1000));

    final id = await database.accounts.insertOne(builder);

    final expectAccountBalance = expectLater(
        database.moneyInBank().watchSingle(),
        emitsInOrder([1000, 2000, 3000, 2000, 1000, 1500]));

    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: 1000,
        description: const Value("description 1"),
        date: DateTime.now()));
    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: 1000,
        description: const Value("description 2"),
        date: DateTime.now()));
    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: -1000,
        description: const Value("description 2"),
        date: DateTime.now()));
    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: -1000,
        description: const Value("description 2"),
        date: DateTime.now()));
    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: 500,
        description: const Value("description 2"),
        date: DateTime.now()));

    await expectAccountBalance;
  });
}
