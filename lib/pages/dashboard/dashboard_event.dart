part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {
  const DashboardEvent();
}

@immutable
final class SaveCategoriesEvent extends DashboardEvent {
  const SaveCategoriesEvent(this.categories);

  final List<Category> categories;

  @override
  String toString() => 'SaveCategoriesEvent(groups: $categories)';
}

@immutable
final class LoadStateEvent extends DashboardEvent {
  final int year;
  final int month;

  const LoadStateEvent(this.year, this.month);

  @override
  String toString() => 'LoadStateEvent(year: $year, month: $month)';
}

@immutable
final class AddTransactionEvent extends DashboardEvent {
  const AddTransactionEvent(this.transaction);

  final BankTransaction transaction;

  @override
  String toString() => 'AddTransactionEvent(transaction: $transaction)';
}
