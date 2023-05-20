import 'package:cat_budget/cubit/category_cubit.dart';
import 'package:cat_budget/widgets/budget_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => CategoryCubit(), child: Test());
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [DrawerHeader(child: Text('CatBudget'))],
          ),
        ),
        appBar: AppBar(title: const Text('Counter')),
        body: BudgetList());
  }
}
