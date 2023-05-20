part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {
  const CategoryEvent();
}

@immutable
final class SaveCategoriesEvent extends CategoryEvent {
  SaveCategoriesEvent(this.groups);

  final List<SaveCategoryGroup> groups;

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
