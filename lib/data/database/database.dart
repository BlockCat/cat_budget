import 'package:cat_budget/data/dao/category_dao.dart';
import 'package:cat_budget/data/models/budget_type.dart';
import 'package:cat_budget/data/models/budget_type_converter.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

@DriftDatabase(include: {
  '../models/schema.drift',
}, daos: [
  CategoryDao
])
class MainDatabase extends _$MainDatabase {
  // This example creates a simple in-memory database (without actual
  // persistence).
  // To store data, see the database setups from other "Getting started" guides.
  MainDatabase(QueryExecutor? queryExecutor)
      : super(queryExecutor ?? NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}

enum CheckingsType { checkings, savings, other }
