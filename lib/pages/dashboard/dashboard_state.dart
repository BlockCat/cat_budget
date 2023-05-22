part of 'dashboard_bloc.dart';

class DashboardState {
  final double moneyToAllocate;
  final double moneyIncome;
  final double moneyExpenses;
  final List<Category> categories;

  const DashboardState(
      {required this.moneyToAllocate,
      required this.moneyIncome,
      required this.moneyExpenses,
      required this.categories});
}

class DashboardStateInitial extends DashboardState {
  DashboardStateInitial()
      : super(
            categories: [],
            moneyToAllocate: 0,
            moneyIncome: 0,
            moneyExpenses: 0);
}
