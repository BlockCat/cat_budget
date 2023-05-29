// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvelopeBudgetData _$EnvelopeBudgetDataFromJson(Map<String, dynamic> json) =>
    EnvelopeBudgetData();

Map<String, dynamic> _$EnvelopeBudgetDataToJson(EnvelopeBudgetData instance) =>
    <String, dynamic>{};

MonthlyBudgetData _$MonthlyBudgetDataFromJson(Map<String, dynamic> json) =>
    MonthlyBudgetData(
      json['monthlyAmount'] as int,
    );

Map<String, dynamic> _$MonthlyBudgetDataToJson(MonthlyBudgetData instance) =>
    <String, dynamic>{
      'monthlyAmount': instance.monthlyAmount,
    };

TargetBudgetData _$TargetBudgetDataFromJson(Map<String, dynamic> json) =>
    TargetBudgetData(
      targetAmount: json['targetAmount'] as int,
      targetDate: DateTime.parse(json['targetDate'] as String),
    );

Map<String, dynamic> _$TargetBudgetDataToJson(TargetBudgetData instance) =>
    <String, dynamic>{
      'targetAmount': instance.targetAmount,
      'targetDate': instance.targetDate.toIso8601String(),
    };
