import 'package:cat_budget/widgets/budget_entry.dart';
import 'package:cat_budget/widgets/expandable_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category/category_bloc.dart';

class BudgetList extends StatelessWidget {
  const BudgetList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      return ListView.builder(
        itemCount: state.groups.length,
        itemBuilder: (context, index) {
          final group = state.groups[index];
          return ExpandableGroup(
              key: Key('budget_list_group_${group.id}'),
              title: group.name,
              children: group.categories
                  .map((e) => BudgetEntry(
                      key: Key('budget_list_entry_${e.id}'), category: e))
                  .toList());
        },
      );
    });
  }
}
