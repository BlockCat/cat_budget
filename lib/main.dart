import 'dart:io';

import 'package:cat_budget/data/database/database.dart';
import 'package:cat_budget/routes.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // HydratedBloc.storage =
  //     await HydratedStorage.build(storageDirectory: 'hydrated_bloc');

  // GetIt.I.registerSingleton<MainDatabase>(
  //     MainDatabase(NativeDatabase.memory(logStatements: true)));
  GetIt.I.registerSingleton<MainDatabase>(
    MainDatabase(LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'cat-budget-db.sqlite'));
      return NativeDatabase.createInBackground(file);
    })),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cat Budget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
