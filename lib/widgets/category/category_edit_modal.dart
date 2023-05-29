import 'package:cat_budget/data/dao/category_dao.dart';
import 'package:cat_budget/data/models/budget_type.dart';
import 'package:cat_budget/widgets/category/budget_type_selection.dart';
import 'package:flutter/material.dart';

class CategoryEditModal extends StatelessWidget {
  final TempCategory? category;
  final TextEditingController _nameController;
  final TextEditingController _descriptionController;
  final ValueNotifier<BudgetData> _budgetDataController;
  final Function()? onClose;
  final Function(String name, String? description, BudgetData budgetData)?
      onSave;

  CategoryEditModal({
    super.key,
    this.category,
    this.onClose,
    this.onSave,
  })  : _nameController =
            TextEditingController(text: category?.category.name.value),
        _descriptionController =
            TextEditingController(text: category?.category.description.value),
        _budgetDataController = ValueNotifier(
            category?.category.budgetData.value ?? EnvelopeBudgetData());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("Edit Category", style: TextStyle(fontSize: 20)),
          Divider(color: Colors.grey[400]),
          TextFormField(
            decoration: const InputDecoration(labelText: "Name"),
            autocorrect: true,
            autofocus: true,
            controller: _nameController,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Description"),
            autocorrect: true,
            controller: _descriptionController,
          ),
          Divider(color: Colors.grey[400]),
          BudgetTypeSelection(budgetDataController: _budgetDataController),
          Divider(color: Colors.grey[400]),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    onClose?.call();
                  },
                  child: const Text("Close"),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("help2: ${_budgetDataController.value.type}");
                    onSave?.call(
                      _nameController.text,
                      _descriptionController.text,
                      _budgetDataController.value,
                    );
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
