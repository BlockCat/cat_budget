import 'package:cat_budget/bloc/category/category_bloc.dart';
import 'package:cat_budget/widgets/budget_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => CategoryBloc(), child: _HomePage());
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [DrawerHeader(child: Text('CatBudget'))],
          ),
        ),
        appBar: AppBar(title: const Text('CatBudget')),
        body: const BudgetList());
  }
}
