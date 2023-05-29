import 'package:cat_budget/data/database/database.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/edit_category_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _selectedDate = DateTime.now();
  EditCategoryState state = const EditCategoryState(categories: []);

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  loadCategories() async {
    final database = GetIt.I.get<MainDatabase>();
    final categories = await database.categoryDao.loadCategories();

    setState(() {
      state = EditCategoryState(categories: categories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatBudget'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await context.push('/categories/edit');
            },
          )
        ],
      ),
      body: ListView(
          children: state.categories
              .expand((e) => [
                    ListTile(
                      title: Text(e.group.group.name.value),
                      subtitle: Text(e.group.group.description.value ?? ''),
                      tileColor: Colors.red[300],
                    ),
                    const Divider(),
                    ...e.children.map(
                      (e) => ListTile(
                        title: Text(e.category.name.value),
                        subtitle: Text(e.category.description.value ?? ''),
                      ),
                    ),
                  ])
              .toList()),
    );
  }
}
