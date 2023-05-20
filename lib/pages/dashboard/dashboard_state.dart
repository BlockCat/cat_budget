part of 'dashboard_bloc.dart';

class DashboardState {
  // Dictorary of categories
  final List<CategoryGroup> groups;

  const DashboardState({this.groups = const []});
}

class CategoryInitial extends DashboardState {
  CategoryInitial() : super(groups: []);
}
