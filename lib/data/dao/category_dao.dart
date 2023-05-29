import 'package:cat_budget/data/database/database.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/edit_category_state.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Category, CategoryGroup])
class CategoryDao extends DatabaseAccessor<MainDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.attachedDatabase);

  Future<List<CategoryTree>> loadCategories() async {
    final categories = await db.allCategories().get();
    final groups = await db.allCategoryGroups().get();

    return groups
        .map(
          (categoryGroup) => CategoryTree(
            TempCategoryGroup(
              key: Key("category-group-loaded-${categoryGroup.id}"),
              group: categoryGroup.toCompanion(true),
            ),
            categories
                .where((element) => element.categoryGroupId == categoryGroup.id)
                .map((category) => TempCategory(
                      key: Key("category-loaded-${category.id}"),
                      category: category.toCompanion(true),
                    ))
                .toList(growable: true),
          ),
        )
        .toList(growable: true);
  }

  Future<void> saveCategories(EditCategoryState state) async {
    final categoryGroups = state.categories;
    await db.transaction(() async {
      final addedGroups = categoryGroups
          .where((element) => element.group.added && !element.group.deleted)
          .toList();

      final removedGroups = categoryGroups
          .where((element) => element.group.deleted)
          .where((element) => element.group.group.id.present)
          .map((e) => e.group.group.id.value)
          .toList();

      final updatedGroups = categoryGroups
          .where((element) => !element.group.added && !element.group.deleted)
          .where((element) => element.group.group.id.present)
          .toList();

      await db.categoryGroups.deleteWhere((tbl) => tbl.id.isIn(removedGroups));

      for (final group in updatedGroups) {
        await (db.categoryGroups.update()
              ..where((tbl) => tbl.id.equals(group.group.group.id.value)))
            .write(group.group.group);

        await updateCategories(group.children, group.group.group.id.value);
      }

      for (final group in addedGroups) {
        assert(!group.group.group.id.present);
        final categoryGroupId =
            await db.categoryGroups.insertOne(group.group.group);

        await updateCategories(group.children, categoryGroupId);
      }
    });
  }

  Future<void> updateCategories(
      List<TempCategory> categories, int groupId) async {
    final sortedCategories = categories.indexed;

    final deletedIds = sortedCategories
        .where((element) => element.$2.deleted)
        .map((e) => e.$2.category.id.value)
        .toList();

    final updatedCategories = sortedCategories
        .where((element) => !element.$2.deleted && !element.$2.added)
        .toList();

    final addedCategories = sortedCategories
        .where((element) => element.$2.added && !element.$2.deleted)
        .toList();

    await db.categories.deleteWhere((tbl) => tbl.id.isIn(deletedIds));

    for (final category in updatedCategories) {
      await (db.categories.update()
            ..where((tbl) => tbl.id.equals(category.$2.category.id.value)))
          .write(category.$2.category.copyWith(sort: Value(category.$1)));
    }

    for (final category in addedCategories) {
      final companion = category.$2.category;
      assert(!companion.id.present);
      await db.categories.insertOne(
        companion.copyWith(categoryGroupId: Value(groupId)),
      );
    }
  }
}

class CategoryTree extends Equatable {
  final TempCategoryGroup group;
  final List<TempCategory> children;

  const CategoryTree(this.group, this.children);

  @override
  List<Object?> get props => [group, children];
}

@immutable
class TempCategoryGroup extends Equatable {
  final Key key;
  final CategoryGroupsCompanion group;
  final bool deleted;
  final bool added;

  const TempCategoryGroup(
      {required this.key,
      required this.group,
      this.deleted = false,
      this.added = false});

  TempCategoryGroup copyWith({
    Key? key,
    CategoryGroupsCompanion? group,
    bool? deleted,
    bool? added,
  }) {
    return TempCategoryGroup(
      key: key ?? this.key,
      group: group ?? this.group,
      deleted: deleted ?? this.deleted,
      added: added ?? this.added,
    );
  }

  @override
  List<Object?> get props => [key, group.id, deleted, added];
}

@immutable
class TempCategory extends Equatable {
  final Key key;
  final CategoriesCompanion category;
  final bool deleted;
  final bool added;

  const TempCategory(
      {required this.key,
      required this.category,
      this.deleted = false,
      this.added = false});

  TempCategory copyWith({
    Key? key,
    CategoriesCompanion? category,
    bool? deleted,
    bool? added,
  }) {
    return TempCategory(
      key: key ?? this.key,
      category: category ?? this.category,
      deleted: deleted ?? this.deleted,
      added: added ?? this.added,
    );
  }

  @override
  List<Object?> get props => [key, category.id, deleted, added];
}
