import 'package:cat_budget/pages/dashboard/edit_categories/edit_category.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

class CategoryEntryWidget extends StatelessWidget {
  final int index;
  final TempCategory child;
  final Function()? onEditCategoryPressed;
  final Function()? onDeleteCategoryPressed;

  const CategoryEntryWidget(
      {super.key,
      required this.child,
      required this.index,
      this.onEditCategoryPressed,
      this.onDeleteCategoryPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Column(
            children: [
              Text(child.name.value,
                  style: child.deleted
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : null),
              if (child.description.present && child.description.value != null)
                Text(child.description.value!, style: subtitleTextStyle),
            ],
          ),
          const Spacer(),
          ..._createButtons(),
          ReorderableDragStartListener(
            index: index,
            enabled: true,
            child: const DragHandle(
                child: Icon(
              Icons.drag_handle,
              size: 24,
            )),
          ),
        ],
      ),
    );
  }

  _createButtons() {
    if (child.deleted) {
      return [
        IconButton(
          icon: const Icon(Icons.auto_delete, color: Colors.red),
          onPressed: () => onDeleteCategoryPressed?.call(),
          iconSize: 24,
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () => onEditCategoryPressed?.call(),
          iconSize: 24,
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDeleteCategoryPressed?.call(),
          iconSize: 24,
        ),
      ];
    }
  }
}
