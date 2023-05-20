part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {
  const DashboardEvent();
}

@immutable
final class SaveCategoriesEvent extends DashboardEvent {
  SaveCategoriesEvent(this.groups);

  final List<CategoryGroup> groups;

  @override
  String toString() => 'SaveCategoriesEvent(groups: $groups)';
}

class SaveCategoryGroup {
  SaveCategoryGroup(this.id, this.name, this.deleted, this.categories);

  final int? id;
  final String name;
  final bool deleted;
  final List<SaveCategory> categories;
}

class SaveCategory {
  SaveCategory(this.id, this.name, this.deleted, this.budget);

  final int? id;
  final String name;
  final bool deleted;
  final double budget;
}
