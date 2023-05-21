part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {
  const DashboardEvent();
}

@immutable
final class SaveCategoriesEvent extends DashboardEvent {
  const SaveCategoriesEvent(this.groups);

  final List<CategoryGroup> groups;

  @override
  String toString() => 'SaveCategoriesEvent(groups: $groups)';
}