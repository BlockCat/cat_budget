import 'package:cat_budget/pages/dashboard/dashboard.dart';
import 'package:cat_budget/repository/account_repository.dart';
import 'package:cat_budget/repository/category_group_repository.dart';
import 'package:cat_budget/repository/category_repository.dart';
import 'package:cat_budget/repository/sqflite/sqlite_account_repository.dart';
import 'package:cat_budget/repository/sqflite/sqlite_category_group_repository.dart';
import 'package:cat_budget/repository/sqflite/sqlite_category_repository.dart';
import 'package:cat_budget/repository/sqflite/sqlite_transaction_repository.dart';
import 'package:cat_budget/repository/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // HydratedBloc.storage =
  //     await HydratedStorage.build(storageDirectory: 'hydrated_bloc');

  final database = GetIt.I.registerSingleton<Database>(await _createDatabase());

  GetIt.I.registerLazySingleton<AccountRepository>(
      () => SqliteAccountRepository(database));
  GetIt.I.registerLazySingleton<CategoryGroupRepository>(
      () => SqliteCategoryGroupRepository(database));
  GetIt.I.registerLazySingleton<CategoryRepository>(
      () => SqliteCategoryRepository(database));
  GetIt.I.registerLazySingleton<TransactionRepository>(
      () => SqliteTransactionRepository(database));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

Future<Database> _createDatabase() async {
  return await openDatabase(
    join(await getDatabasesPath(), 'cat_budget.db'),
    onCreate: (db, version) async {
      await _runMigrations(db, version);
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      await _runMigrations(db, oldVersion);
    },
    version: 1,
  );
}

_runMigrations(Database db, int version) async {
  if (version >= 1) {
    await db.execute("""
      CREATE TABLE accounts(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT UNIQUE NOT NULL,
        type ENUM('checking', 'savings', 'other') NOT NULL,
        lastUpdated DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
      )
""");
    await db.execute("""
      CREATE TABLE category_groups(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT UNIQUE NOT NULL,
        sort INTEGER
      )
""");
    await db.execute("""
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT UNIQUE NOT NULL,
        budget REAL NOT NULL,
        targetDate DATE NULL,
        type ENUM("budget", "goal") NOT NULL,
        categoryGroupId INTEGER NOT NULL,
        sort INTEGER,
        FOREIGN KEY(categoryGroupId) REFERENCES category_groups(id) ON DELETE CASCADE
      )
  """);
    await db.execute("""
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        account_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        date DATE NOT NULL,
        description TEXT,
        FOREIGN KEY(account_id) REFERENCES accounts(id) ON DELETE CASCADE,
        FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE SET NULL
      )
""");
  }
}
