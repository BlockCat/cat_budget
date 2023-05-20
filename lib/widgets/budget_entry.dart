import 'package:cat_budget/models/category.dart';
import 'package:flutter/widgets.dart';

class BudgetEntry extends StatelessWidget {
  const BudgetEntry({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(category.name),
            Text('Total ${category.total}/${category.budget}'),            
          ],          
        )
      ],
    );
  }
}
