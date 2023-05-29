import 'package:json_annotation/json_annotation.dart' as j;

part 'budget_type.g.dart';

enum BudgetType {
  envelope,
  monthly,
  target,
}

abstract class BudgetData {
  BudgetType get type;

  factory BudgetData.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String?) {
      case 'envelope':
        return EnvelopeBudgetData();
      case 'monthly':
        return MonthlyBudgetData.fromJson(json);
      case 'target':
        return TargetBudgetData.fromJson(json);
      default:
        return EnvelopeBudgetData();
    }
  }

  Map<String, dynamic> toJson();
}

@j.JsonSerializable()
class EnvelopeBudgetData implements BudgetData {
  @override
  final BudgetType type = BudgetType.envelope;

  @override
  Map<String, dynamic> toJson() {
    return _$EnvelopeBudgetDataToJson(this);
  }
}

@j.JsonSerializable()
class MonthlyBudgetData implements BudgetData {
  @override
  final BudgetType type = BudgetType.monthly;

  final int monthlyAmount;

  MonthlyBudgetData(this.monthlyAmount);

  @override
  Map<String, dynamic> toJson() {
    return _$MonthlyBudgetDataToJson(this);
  }

  factory MonthlyBudgetData.fromJson(Map<String, dynamic> json) {
    return _$MonthlyBudgetDataFromJson(json);
  }
}

@j.JsonSerializable()
class TargetBudgetData implements BudgetData {
  @override
  final BudgetType type = BudgetType.target;

  final int targetAmount;
  final DateTime targetDate;

  TargetBudgetData({required this.targetAmount, required this.targetDate})
      : assert(targetAmount >= 0),
        assert(targetDate.isUtc);

  /// Returns the monthly amount that should be budgeted for the given date.
  /// If the date is after the target date, returns balance left.
  int monthlyAmount(DateTime date, int balance) {
    final remainingMoney = targetAmount - balance;
    if (date.isAfter(targetDate)) {
      if (balance >= targetAmount) {
        return 0;
      } else {
        return remainingMoney;
      }
    }

    final monthsLeft =
        (targetDate.year - date.year) * 12 + targetDate.month - date.month;
    return (remainingMoney / monthsLeft).ceil();
  }

  factory TargetBudgetData.fromJson(Map<String, dynamic> json) {
    return _$TargetBudgetDataFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TargetBudgetDataToJson(this);
  }
}
