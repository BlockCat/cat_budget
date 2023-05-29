import 'dart:convert';

import 'package:cat_budget/data/models/budget_type.dart';
import 'package:drift/drift.dart';

class BudgetTypeConverter extends TypeConverter<BudgetData, String> {
  const BudgetTypeConverter();

  @override
  BudgetData fromSql(String fromDb) {
    return BudgetData.fromJson(json.decode(fromDb));
  }

  @override
  String toSql(BudgetData value) {
    return json.encode(value.toJson());
  }
}
