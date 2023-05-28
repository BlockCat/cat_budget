import 'package:cat_budget/data/dao/category_dao.dart';
import 'package:cat_budget/data/database/database.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/edit_category_state.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EditCategoryState state;

  setUp(() {
    state = const EditCategoryState(categories: [
      CategoryTree(
          TempCategoryGroup(
            key: Key('0'),
            group: CategoryGroupsCompanion(
                id: Value(0),
                name: Value('group_1'),
                description: Value('group_1 description'),
                sort: Value(0)),
          ),
          [
            TempCategory(
              key: Key('c0'),
              category: CategoriesCompanion(
                id: Value(0),
                name: Value('category_1'),
                description: Value('category_1 description'),
                sort: Value(0),
                categoryGroupId: Value(0),
              ),
            ),
            TempCategory(
              key: Key('c1'),
              category: CategoriesCompanion(
                id: Value(1),
                name: Value('category_2'),
                description: Value('category_2 description'),
                sort: Value(1),
                categoryGroupId: Value(0),
              ),
            ),
          ]),
    ]);
  });

  test('add category', () {
    final tree = state.categories.first;
    final result = state.addCategory(
        tree,
        const CategoriesCompanion(
          id: Value.absent(),
          name: Value('category_3'),
          description: Value('category_3 description'),
          sort: Value(2),
        ));

    expect(
      result,
      const EditCategoryState(counter: 1, categories: [
        CategoryTree(
          TempCategoryGroup(
            key: Key('0'),
            group: CategoryGroupsCompanion(
                id: Value(0),
                name: Value('group_1'),
                description: Value('group_1 description'),
                sort: Value(0)),
          ),
          [
            TempCategory(
              key: Key('c0'),
              category: CategoriesCompanion(
                id: Value(0),
                name: Value('category_1'),
                description: Value('category_1 description'),
                sort: Value(0),
                categoryGroupId: Value(0),
              ),
            ),
            TempCategory(
              key: Key('c1'),
              category: CategoriesCompanion(
                id: Value(1),
                name: Value('category_2'),
                description: Value('category_2 description'),
                sort: Value(1),
                categoryGroupId: Value(0),
              ),
            ),
            TempCategory(
                key: Key('category-created-0'),
                category: CategoriesCompanion(
                  id: Value.absent(),
                  name: Value('category_3'),
                  description: Value('category_3 description'),
                  sort: Value(2),
                  categoryGroupId: Value(0),
                ),
                added: true)
          ],
        ),
      ]),
    );
  });

  test('delete category', () {
    final tree = state.categories.first;
    final result = state.toggleDeletionCategory(tree, tree.children.first);

    expect(
      result,
      const EditCategoryState(categories: [
        CategoryTree(
            TempCategoryGroup(
              key: Key('0'),
              group: CategoryGroupsCompanion(
                  id: Value(0),
                  name: Value('group_1'),
                  description: Value('group_1 description'),
                  sort: Value(0)),
            ),
            [
              TempCategory(
                  key: Key('c0'),
                  category: CategoriesCompanion(
                    id: Value(0),
                    name: Value('category_1'),
                    description: Value('category_1 description'),
                    sort: Value(0),
                    categoryGroupId: Value(0),
                  ),
                  deleted: true),
              TempCategory(
                key: Key('c1'),
                category: CategoriesCompanion(
                  id: Value(1),
                  name: Value('category_2'),
                  description: Value('category_2 description'),
                  sort: Value(1),
                  categoryGroupId: Value(0),
                ),
              ),
            ]),
      ]),
    );
  });

  test('update category', () {
    final tree = state.categories.first;
    final result = state.updateCategory(
      tree,
      const TempCategory(
        key: Key('c0'),
        category: CategoriesCompanion(
          id: Value(0),
          name: Value('category_3 UPDATED NAME'),
          description: Value('Updated description'),
          sort: Value(3),
          categoryGroupId: Value(0),
        ),
      ),
    );

    expect(
      result,
      const EditCategoryState(categories: [
        CategoryTree(
            TempCategoryGroup(
              key: Key('0'),
              group: CategoryGroupsCompanion(
                  id: Value(0),
                  name: Value('group_1'),
                  description: Value('group_1 description'),
                  sort: Value(0)),
            ),
            [
              TempCategory(
                key: Key('c0'),
                category: CategoriesCompanion(
                  id: Value(0),
                  name: Value('category_3 UPDATED NAME'),
                  description: Value('Updated description'),
                  sort: Value(3),
                  categoryGroupId: Value(0),
                ),
              ),
              TempCategory(
                key: Key('c1'),
                category: CategoriesCompanion(
                  id: Value(1),
                  name: Value('category_2'),
                  description: Value('category_2 description'),
                  sort: Value(1),
                  categoryGroupId: Value(0),
                ),
              ),
            ]),
      ]),
    );
  });

  test('add category group', () {
    final result = state.addCategoryGroup(
      CategoryGroupsCompanion.insert(
        name: "Group added",
        description: const Value("Group added description"),
        sort: const Value(1),
      ),
    );
    expect(
      result,
      const EditCategoryState(categories: [
        CategoryTree(
            TempCategoryGroup(
              key: Key('0'),
              group: CategoryGroupsCompanion(
                  id: Value(0),
                  name: Value('group_1'),
                  description: Value('group_1 description'),
                  sort: Value(0)),
            ),
            [
              TempCategory(
                key: Key('c0'),
                category: CategoriesCompanion(
                  id: Value(0),
                  name: Value('category_1'),
                  description: Value('category_1 description'),
                  sort: Value(0),
                  categoryGroupId: Value(0),
                ),
              ),
              TempCategory(
                key: Key('c1'),
                category: CategoriesCompanion(
                  id: Value(1),
                  name: Value('category_2'),
                  description: Value('category_2 description'),
                  sort: Value(1),
                  categoryGroupId: Value(0),
                ),
              ),
            ]),
        CategoryTree(
            TempCategoryGroup(
              key: Key('category-group-added-0'),
              added: true,
              group: CategoryGroupsCompanion(
                  id: Value.absent(),
                  name: Value('Group added'),
                  description: Value('Group added description'),
                  sort: Value(1)),
            ),
            []),
      ]),
    );
  });

  test('delete category group', () {
    final result = state.toggleDeletionCategoryGroup(state.categories.first);
    expect(
      result,
      const EditCategoryState(categories: [
        CategoryTree(
            TempCategoryGroup(
              key: Key('0'),
              deleted: true,
              group: CategoryGroupsCompanion(
                  id: Value(0),
                  name: Value('group_1'),
                  description: Value('group_1 description'),
                  sort: Value(0)),
            ),
            [
              TempCategory(
                key: Key('c0'),
                deleted: true,
                category: CategoriesCompanion(
                  id: Value(0),
                  name: Value('category_1'),
                  description: Value('category_1 description'),
                  sort: Value(0),
                  categoryGroupId: Value(0),
                ),
              ),
              TempCategory(
                key: Key('c1'),
                deleted: true,
                category: CategoriesCompanion(
                  id: Value(1),
                  name: Value('category_2'),
                  description: Value('category_2 description'),
                  sort: Value(1),
                  categoryGroupId: Value(0),
                ),
              ),
            ]),
      ]),
    );
  });

  test('update category group', () {
    final tree = state.categories.first;
    final result = state.updateCategoryGroup(
      tree,
      const CategoryGroupsCompanion(
        id: Value(0),
        name: Value('group_1 UPDATED NAME'),
        description: Value('Updated description'),
        sort: Value(3),
      ),
    );

    expect(
      result,
      const EditCategoryState(categories: [
        CategoryTree(
            TempCategoryGroup(
              key: Key('0'),
              group: CategoryGroupsCompanion(
                  id: Value(0),
                  name: Value('group_1 UPDATED NAME'),
                  description: Value('Updated description'),
                  sort: Value(3)),
            ),
            [
              TempCategory(
                key: Key('c0'),
                category: CategoriesCompanion(
                  id: Value(0),
                  name: Value('category_1'),
                  description: Value('category_1 description'),
                  sort: Value(0),
                  categoryGroupId: Value(0),
                ),
              ),
              TempCategory(
                key: Key('c1'),
                category: CategoriesCompanion(
                  id: Value(1),
                  name: Value('category_2'),
                  description: Value('category_2 description'),
                  sort: Value(1),
                  categoryGroupId: Value(0),
                ),
              ),
            ]),
      ]),
    );
  });
}
