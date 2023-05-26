import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

@DriftDatabase(
  include: {
    '../models/schema.drift',
  },
)
class MainDatabase extends _$MainDatabase {
  // This example creates a simple in-memory database (without actual
  // persistence).
  // To store data, see the database setups from other "Getting started" guides.
  MainDatabase() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}

enum CheckingsType { checkings, savings, other }
