import 'package:cat_budget/data/database/database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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
        balance: const Value(10.0));

    await database.accounts.insertOne(builder);

    final expectAccountBalance = expectLater(
        database.moneyInBank().watchSingle(), emitsInOrder([10, 20, 30]));

    final id = await database.accounts.insertOne(AccountsCompanion.insert(
        name: "name2", type: 0, balance: const Value(10.0)));

    await (database.update(database.accounts)
          ..where((tbl) => tbl.id.equals(id)))
        .write(const AccountsCompanion(balance: Value(20.0)));

    expect(await database.moneyInBank().getSingle(), 30);
    await expectAccountBalance;
  });

  test('account updates after transactions', () async {
    final builder = AccountsCompanion.insert(
        name: "name",
        type: 0,
        description: const Value("description"),
        balance: const Value(10.0));

    final id = await database.accounts.insertOne(builder);

    final expectAccountBalance = expectLater(
        database.moneyInBank().watchSingle(),
        emitsInOrder([10, 20, 30, 20, 10, 15]));

    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: 10.0,
        description: const Value("description 1"),
        date: DateTime.now()));
    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: 10.0,
        description: const Value("description 2"),
        date: DateTime.now()));
    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: -10.0,
        description: const Value("description 2"),
        date: DateTime.now()));
    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: -10.0,
        description: const Value("description 2"),
        date: DateTime.now()));
    await database.bankTransactions.insertOne(BankTransactionsCompanion.insert(
        accountId: id,
        amount: 5.0,
        description: const Value("description 2"),
        date: DateTime.now()));

    await expectAccountBalance;
  });
}
