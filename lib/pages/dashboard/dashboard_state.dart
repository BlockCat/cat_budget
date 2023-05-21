part of 'dashboard_bloc.dart';

class DashboardState {
  
  final List<CategoryGroup> groups;

  const DashboardState({this.groups = const []});
}

class DashboardStateInitial extends DashboardState {
  DashboardStateInitial() : super(groups: []);
}
