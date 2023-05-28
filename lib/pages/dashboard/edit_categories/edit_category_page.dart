import 'package:cat_budget/data/database/database.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/entry_category.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/edit_category.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/entry_group_category.dart';
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
                await saveCategories(state._categories);
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
  List<CategoryTree> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    final database = GetIt.I.get<MainDatabase>();
    final categories = await loadCategories(database);

    setState(() {
      _categories = categories;
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
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final categoryTree = _categories[index];
                return Column(
                    key: Key('group-${categoryTree.group.id}'),
                    children: [
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
                            key: Key('category-${child.id.value}'),
                            child: child,
                            index: index,
                            onEditCategoryPressed: () => _onEditCategoryPressed(
                                categoryTree, child, index),
                            onDeleteCategoryPressed: () =>
                                _onDeleteCategoryPressed(
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

    if (category.name.value.isEmpty) return;

    setState(() {
      categoryTree.children.add(category);
    });
  }

  _onEditCategoryPressed(
      CategoryTree categoryTree, TempCategory child, int childIndex) async {
    TempCategory category = await _openEditCategoryModal(child, categoryTree);

    setState(() {
      categoryTree.children[childIndex] = category;
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
            child.copyTempWith(deleted: !child.deleted);
      });
    }
  }

  Future<TempCategory> _openEditCategoryModal(
      TempCategory? category, CategoryTree categoryTree) async {
    final nameController = TextEditingController(text: category?.name.value);
    final descriptionController =
        TextEditingController(text: category?.description.value);
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

    return TempCategory(
      id: category?.id.value ?? categoryTree.children.length + 1,
      added: category == null ? true : category.added,
      name: nameController.text,
      description: descriptionController.text,
    );
  }

  void _onDeleteCategoryGroupPressed(BuildContext context, int groupIndex) {
    final group = _categories[groupIndex].group;
    if (group.added && _categories[groupIndex].children.isEmpty) {
      setState(() {
        _categories.removeAt(groupIndex);
      });
    } else {
      setState(() {
        _categories[groupIndex] = CategoryTree(
          _categories[groupIndex]
              .group
              .copyTempWith(deleted: !_categories[groupIndex].group.deleted),
          _categories[groupIndex].children,
        );
      });
    }
  }

  void _onEditCategoryGroupPressed(BuildContext context, int groupIndex) async {
    final group = _categories[groupIndex].group;
    final textController = TextEditingController(text: group.name.value);
    final descriptionController =
        TextEditingController(text: group.description.value);
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

    if (textController.text != group.name.value ||
        descriptionController.text != group.description.value) {
      setState(() {
        _categories[groupIndex] = CategoryTree(
          TempCategoryGroup(
            id: group.id.value,
            name: textController.text,
            description: descriptionController.text,
            added: group.added,
            deleted: group.deleted,
          ),
          _categories[groupIndex].children,
        );
      });
    }
  }

  void _onAddCategoryGroupPressed() {
    setState(() {
      _categories = [
        ..._categories,
        CategoryTree(
          TempCategoryGroup(
              id: _categories.length + 1,
              name: "<unnamed>",
              description: null,
              added: true),
          [],
        )
      ];
    });
  }
}
