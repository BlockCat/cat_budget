import 'package:cat_budget/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // HydratedBloc.storage =
  //     await HydratedStorage.build(storageDirectory: 'hydrated_bloc');
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

_createDatabase() async {
  return openDatabase(
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
        sort INTEGER)
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
        FOREIGN KEY(categoryGroupId) REFERENCES category_groups(id))
  """);
    await db.execute("""
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        account_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        date DATE NOT NULL,
        description TEXT,
        FOREIGN KEY(account_id) REFERENCES accounts(id),
        FOREIGN KEY(category_id) REFERENCES categories(id)
      )
""");
  }
}
