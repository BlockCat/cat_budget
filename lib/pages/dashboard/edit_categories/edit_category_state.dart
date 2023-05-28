import 'package:cat_budget/data/dao/category_dao.dart';
import 'package:cat_budget/data/database/database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class EditCategoryState extends Equatable {
  final int counter;
  final List<CategoryTree> categories;

  const EditCategoryState({this.categories = const [], this.counter = 0});

  EditCategoryState addCategoryGroup(CategoryGroupsCompanion group) {
    return EditCategoryState(
      counter: counter + 1,
      categories: [
        ...categories,
        CategoryTree(
          TempCategoryGroup(
            key: Key("category-group-added-$counter"),
            group: group,
            added: true,
          ),
          const [],
        ),
      ],
    );
  }

  EditCategoryState toggleDeletionCategoryGroup(CategoryTree categoryTree) {
    int index = categories
        .indexWhere((element) => element.group.key == categoryTree.group.key);
    return EditCategoryState(counter: counter, categories: [
      ...categories.sublist(0, index),
      CategoryTree(
        categoryTree.group.copyWith(deleted: !categoryTree.group.deleted),
        categoryTree.children
            .map((e) => e.copyWith(deleted: !e.deleted))
            .toList(growable: true),
      ),
      ...categories.sublist(index + 1),
    ]);
  }

  EditCategoryState updateCategoryGroup(
      CategoryTree categoryTree, CategoryGroupsCompanion group) {
    int index = categories
        .indexWhere((element) => element.group.key == categoryTree.group.key);
    return EditCategoryState(
      counter: counter,
      categories: [
        ...categories.sublist(0, index),
        CategoryTree(
          categoryTree.group.copyWith(group: group),
          categoryTree.children,
        ),
        ...categories.sublist(index + 1),
      ],
    );
  }

  EditCategoryState addCategory(
      CategoryTree categoryTree, CategoriesCompanion category) {
    int index = categories
        .indexWhere((element) => element.group.key == categoryTree.group.key);
    return EditCategoryState(
      counter: counter + 1,
      categories: [
        ...categories.sublist(0, index),
        CategoryTree(
          categoryTree.group,
          [
            ...categoryTree.children,
            TempCategory(
              key: Key("category-created-$counter"),
              category: category,
              added: true,
            ),
          ],
        ),
        ...categories.sublist(index + 1),
      ],
    );
  }

  EditCategoryState updateCategory(
      CategoryTree categoryTree, TempCategory category) {
    int groupIndex = categories
        .indexWhere((element) => element.group.key == categoryTree.group.key);
    int categoryIndex = categoryTree.children
        .indexWhere((element) => element.key == category.key);
    return EditCategoryState(
      counter: counter,
      categories: [
        ...categories.sublist(0, groupIndex),
        CategoryTree(
          categoryTree.group,
          [
            ...categoryTree.children.sublist(0, categoryIndex),
            category,
            ...categoryTree.children.sublist(categoryIndex + 1),
          ],
        ),
        ...categories.sublist(groupIndex + 1),
      ],
    );
  }

  EditCategoryState toggleDeletionCategory(
      CategoryTree categoryTree, TempCategory category) {
    int groupIndex = categories
        .indexWhere((element) => element.group.key == categoryTree.group.key);
    int categoryIndex = categoryTree.children
        .indexWhere((element) => element.key == category.key);
    return EditCategoryState(
      counter: counter,
      categories: [
        ...categories.sublist(0, groupIndex),
        CategoryTree(
          categoryTree.group,
          [
            ...categoryTree.children.sublist(0, categoryIndex),
            category.copyWith(deleted: !category.deleted),
            ...categoryTree.children.sublist(categoryIndex + 1),
          ],
        ),
        ...categories.sublist(groupIndex + 1),
      ],
    );
  }

  @override
  List<Object?> get props => [categories];
}
