import 'package:cat_budget/data/dao/category_dao.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/edit_category.dart';
import 'package:flutter/material.dart';

class CategoryGroupEntryWidget extends StatelessWidget {
  final CategoryTree categoryTree;
  final Function(CategoryTree)? onAddCategoryPressed;
  final Function(CategoryTree)? onDeleteCategoryGroupPressed;
  final Function(CategoryTree)? onEditCategoryGroupPressed;

  const CategoryGroupEntryWidget(
      {super.key,
      required this.categoryTree,
      this.onAddCategoryPressed,
      this.onEditCategoryGroupPressed,
      this.onDeleteCategoryGroupPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 65, 146, 102),
      padding: const EdgeInsets.fromLTRB(3, 1, 0, 1),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                categoryTree.group.group.name.value,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              if (categoryTree.group.group.description.present)
                Text(
                  categoryTree.group.group.description.value!,
                  style: subtitleTextStyle.copyWith(color: Colors.white),
                ),
            ],
          ),
          const Spacer(),
          ..._buildButtons()
        ],
      ),
    );
  }

  List<Widget> _buildButtons() {
    if (categoryTree.group.deleted) {
      return [
        IconButton(
          icon: const Icon(Icons.auto_delete),
          onPressed: () => onDeleteCategoryGroupPressed?.call(categoryTree),
          color: Colors.white,
          iconSize: 24,
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => onEditCategoryGroupPressed?.call(categoryTree),
          color: Colors.white,
          iconSize: 24,
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => onDeleteCategoryGroupPressed?.call(categoryTree),
          color: Colors.white,
          iconSize: 24,
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => onAddCategoryPressed?.call(categoryTree),
          color: Colors.white,
          iconSize: 24,
        )
      ];
    }
  }
}
