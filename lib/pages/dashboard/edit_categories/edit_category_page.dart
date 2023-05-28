import 'package:cat_budget/data/dao/category_dao.dart';
import 'package:cat_budget/data/database/database.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/edit_category_state.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/entry_category.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/entry_group_category.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class EditCategoryPage extends StatelessWidget {
  EditCategoryPage({Key? key}) : super(key: key);

  final categoryListKey = GlobalKey(debugLabel: "categoryListKey");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Categories"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final state =
                  categoryListKey.currentState as _CategoryListEditorState?;
              if (state != null) {
                await GetIt.I
                    .get<MainDatabase>()
                    .categoryDao
                    .saveCategories(state.state);
                await state._loadCategories();
                // return context.pop();
              }
              // return context.pop();
            },
            child: const Text("Save or something"),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CategoryListEditor(
                  key: categoryListKey,
                )),
          ),
        ],
      ),
    );
  }
}

class CategoryListEditor extends StatefulWidget {
  const CategoryListEditor({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryListEditorState();
}

class _CategoryListEditorState extends State<CategoryListEditor> {
  EditCategoryState state = const EditCategoryState();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    final database = GetIt.I.get<MainDatabase>();
    final categories = await database.categoryDao.loadCategories();

    setState(() {
      state = EditCategoryState(categories: categories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _onAddCategoryGroupPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 59, 148, 221),
              foregroundColor: Colors.white,
            ),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text("Add Category Group"),
                ]),
          ),
        ),
        Expanded(
          child: ListView.builder(
              key: const Key("category-list"),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final categoryTree = state.categories[index];
                return Column(key: categoryTree.group.key, children: [
                  CategoryGroupEntryWidget(
                    categoryTree: categoryTree,
                    onAddCategoryPressed: _onAddCategoryPressed,
                    onEditCategoryGroupPressed: (tree) =>
                        _onEditCategoryGroupPressed(context, index),
                    onDeleteCategoryGroupPressed: (p0) {
                      _onDeleteCategoryGroupPressed(context, index);
                    },
                  ),
                  ReorderableListView.builder(
                    shrinkWrap: true,
                    itemCount: categoryTree.children.length,
                    buildDefaultDragHandles: false,
                    clipBehavior: Clip.hardEdge,
                    dragStartBehavior: DragStartBehavior.down,
                    onReorder: (a, b) {
                      setState(() {
                        if (b > a) b--;
                        final item = categoryTree.children.removeAt(a);
                        categoryTree.children.insert(b, item);
                      });
                    },
                    itemBuilder: (context, index) {
                      final child = categoryTree.children[index];
                      return CategoryEntryWidget(
                        key: Key('category-${child.key}'),
                        child: child,
                        index: index,
                        onEditCategoryPressed: () =>
                            _onEditCategoryPressed(categoryTree, child, index),
                        onDeleteCategoryPressed: () => _onDeleteCategoryPressed(
                            categoryTree, child, index),
                      );
                    },
                  )
                ]);
              }),
        ),
      ],
    );
  }

  void _onAddCategoryPressed(CategoryTree categoryTree) async {
    TempCategory category = await _openEditCategoryModal(null, categoryTree);

    if (category.category.name.value.isEmpty) return;

    setState(() {
      state = state.addCategory(categoryTree, category.category);
    });
  }

  _onEditCategoryPressed(
      CategoryTree categoryTree, TempCategory child, int childIndex) async {
    TempCategory category = await _openEditCategoryModal(child, categoryTree);

    setState(() {
      state = state.updateCategory(categoryTree, category);
    });
  }

  _onDeleteCategoryPressed(
      CategoryTree categoryTree, TempCategory child, int childIndex) async {
    if (child.added) {
      setState(() {
        categoryTree.children.removeAt(childIndex);
      });
    } else {
      setState(() {
        categoryTree.children[childIndex] =
            child.copyWith(deleted: !child.deleted);
      });
    }
  }

  Future<TempCategory> _openEditCategoryModal(
      TempCategory? category, CategoryTree categoryTree) async {
    final nameController =
        TextEditingController(text: category?.category.name.value);
    final descriptionController =
        TextEditingController(text: category?.category.description.value);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(10),
          // height: 210,
          child: Column(
            children: [
              const Text("Edit Category", style: TextStyle(fontSize: 20)),
              Divider(color: Colors.grey[400]),
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                autocorrect: true,
                autofocus: true,
                controller: nameController,
              ),
              TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  autocorrect: true,
                  controller: descriptionController),
              Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (category == null) {
      return TempCategory(
        key: const Key('unused-key'),
        category: CategoriesCompanion.insert(
          name: nameController.text,
          description: descriptionController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(descriptionController.text),
        ),
        added: true,
      );
    }

    return TempCategory(
      key: category.key,
      category: category.category.copyWith(
        name: drift.Value(nameController.text),
        description: descriptionController.text.isEmpty
            ? const drift.Value.absent()
            : drift.Value(descriptionController.text),
      ),
      added: category.added,
      deleted: category.deleted,
    );
  }

  void _onDeleteCategoryGroupPressed(BuildContext context, int groupIndex) {
    final group = state.categories[groupIndex];
    setState(() {
      state = state.toggleDeletionCategoryGroup(group);
    });
  }

  void _onEditCategoryGroupPressed(BuildContext context, int groupIndex) async {
    final group = state.categories[groupIndex].group;
    final textController = TextEditingController(text: group.group.name.value);
    final descriptionController =
        TextEditingController(text: group.group.description.value);
    await showModalBottomSheet<String?>(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(10),
          height: 250,
          child: Column(
            children: [
              const Text("Edit Group", style: TextStyle(fontSize: 20)),
              Divider(color: Colors.grey[400]),
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                controller: textController,
                autocorrect: true,
                autofocus: true,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                controller: descriptionController,
                autocorrect: true,
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop(textController.text);
                },
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
    );

    if (textController.text != group.group.name.value ||
        descriptionController.text != group.group.description.value) {
      final tree = state.categories[groupIndex];
      setState(() {
        state = state.updateCategoryGroup(
            tree,
            tree.group.group.copyWith(
              name: drift.Value(textController.text),
              description: descriptionController.text.isEmpty
                  ? const drift.Value.absent()
                  : drift.Value(descriptionController.text),
            ));
      });
    }
  }

  void _onAddCategoryGroupPressed() {
    setState(() {
      state = state
          .addCategoryGroup(CategoryGroupsCompanion.insert(name: "<unnamed>"));
    });
  }
}
