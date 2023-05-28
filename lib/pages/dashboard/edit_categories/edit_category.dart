import 'package:cat_budget/data/database/database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

const subtitleTextStyle =
    TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic);

class CategoryTree {
  final TempCategoryGroup group;
  final List<TempCategory> children;

  CategoryTree(this.group, this.children);
}

@immutable
class TempCategoryGroup extends CategoryGroupsCompanion {
  final bool deleted;
  final bool added;

  TempCategoryGroup({
    required int id,
    required String name,
    String? description,
    this.deleted = false,
    this.added = false,
  }) : super(
          id: drift.Value.ofNullable(id),
          name: drift.Value(name),
          description: description == null
              ? const drift.Value.absent()
              : drift.Value(description),
        );

  TempCategoryGroup copyTempWith({
    int? id,
    String? name,
    String? description,
    bool? deleted,
    bool? added,
  }) {
    return TempCategoryGroup(
      id: id ?? this.id.value,
      name: name ?? this.name.value,
      description: description ?? this.description.value,
      deleted: deleted ?? this.deleted,
      added: added ?? this.added,
    );
  }
}

@immutable
class TempCategory extends CategoriesCompanion {
  final bool deleted;
  final bool added;

  TempCategory(
      {required int id,
      required String name,
      String? description,
      this.deleted = false,
      this.added = false})
      : super(
          id: drift.Value.ofNullable(id),
          name: drift.Value(name),
          description: drift.Value(description),
        );

  TempCategory copyTempWith({
    int? id,
    String? name,
    String? description,
    bool? deleted,
    bool? added,
  }) {
    return TempCategory(
      id: id ?? this.id.value,
      name: name ?? this.name.value,
      description: description ?? this.description.value,
      deleted: deleted ?? this.deleted,
      added: added ?? this.added,
    );
  }
}

Future<List<CategoryTree>> loadCategories(MainDatabase database) async {
  final categories = await database.allCategories().get();
  final groups = await database.allCategoryGroups().get();

  return groups
      .map(
        (categoryGroup) => CategoryTree(
          TempCategoryGroup(
            id: categoryGroup.id,
            name: categoryGroup.name,
            description: categoryGroup.description,
          ),
          categories
              .where((element) => element.categoryGroupId == categoryGroup.id)
              .map((category) => TempCategory(
                    id: category.id,
                    name: category.name,
                    description: category.description,
                  ))
              .toList(growable: true),
        ),
      )
      .toList(growable: true);
}

Future<void> saveCategories(List<CategoryTree> categoryGroups) async {
  final database = GetIt.I.get<MainDatabase>();

  await database.transaction(() async {
    final addedGroups = categoryGroups
        .where((element) => element.group.added && !element.group.deleted)
        .toList();

    final removedGroups = categoryGroups
        .where((element) => element.group.deleted)
        .where((element) => element.group.id.present)
        .map((e) => e.group.id.value)
        .toList();

    final updatedGroups = categoryGroups
        .where((element) => !element.group.added && !element.group.deleted)
        .where((element) => element.group.id.present)
        .toList();

    await database.categoryGroups.deleteWhere((tbl) => tbl.id.isIn(removedGroups));

    for (final group in updatedGroups) {
      await (database.categoryGroups.update()
            ..where((tbl) => tbl.id.equals(group.group.id.value)))
          .write(group.group.copyWith(id: drift.Value(group.group.id.value)));

      await _updateCategories(database, group.children, group.group.id.value);
    }

    for (final group in addedGroups) {
      final categoryGroupId = await database.categoryGroups
          .insertOne(group.group.copyWith(id: const drift.Value.absent()));

      await _updateCategories(database, group.children, categoryGroupId);
    }
  });
}

_updateCategories(
    MainDatabase database, List<TempCategory> categories, int groupId) async {
  final sortedCategories = categories.indexed;

  final deletedIds = sortedCategories
      .where((element) => element.$2.deleted)
      .map((e) => e.$2.id.value)
      .toList();

  final updatedCategories = sortedCategories
      .where((element) => !element.$2.deleted && !element.$2.added)
      .toList();

  final addedCategories = sortedCategories
      .where((element) => element.$2.added && !element.$2.deleted)
      .toList();

  await database.categories.deleteWhere((tbl) => tbl.id.isIn(deletedIds));

  for (final category in updatedCategories) {
    await (database.categories.update()
          ..where((tbl) => tbl.id.equals(category.$2.id.value)))
        .write(category.$2.copyWith(sort: drift.Value(category.$1)));
  }

  for (final category in addedCategories) {
    await database.categories.insertOne(
      category.$2.copyWith(
        id: const drift.Value.absent(),
        categoryGroupId: drift.Value(groupId),
        sort: drift.Value(category.$1),
      ),
    );
  }
}
