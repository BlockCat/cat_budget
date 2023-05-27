import 'package:cat_budget/data/database/database.dart';
import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

class EditCategoryPage extends StatelessWidget {
  const EditCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Categories"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text("Save or something"),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(10),
                child: CategoryListEditor(),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(7.0),
                )),
          ),
        ],
      ),
    );
  }
}

class CategoryListEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryListEditorState();
}

class _CategoryListEditorState extends State<CategoryListEditor> {
  List<DragAndDropList> _entries = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _entries = [
        DragAndDropList(
          header: _CategoryListGroupEntry(
            const CategoryGroup(id: 0, name: "Group 1"),
          ),
          children: [
            DragAndDropItem(child: const ListTile(title: Text('Category 1'))),
            DragAndDropItem(child: const ListTile(title: Text('Category 2'))),
            DragAndDropItem(child: const ListTile(title: Text('Category 3'))),
          ],
        ),
        DragAndDropList(
          header: _CategoryListGroupEntry(
            const CategoryGroup(id: 1, name: "Group 3"),
          ),
          children: [
            DragAndDropItem(child: const ListTile(title: Text('Category 4'))),
            DragAndDropItem(child: const ListTile(title: Text('Category 5'))),
            DragAndDropItem(child: const ListTile(title: Text('Category 6'))),
          ],
        ),
        DragAndDropList(
          header: _CategoryListGroupEntry(
            const CategoryGroup(id: 2, name: "Group 2"),
          ),
          children: [
            DragAndDropItem(
              child: const ListTile(title: Text('Category 7')),
            ),
            DragAndDropItem(
              child: const ListTile(title: Text('Category 8')),
              feedbackWidget: const ListTile(title: Text('Category 8')),
            ),
            DragAndDropItem(
              child: const ListTile(title: Text('Category 9')),
            ),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragAndDropLists(
      children: _entries,
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
      listGhost: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 100.0),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: const Icon(Icons.add_box),
          ),
        ),
      ),
      listPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      contentsWhenEmpty: Row(
        children: <Widget>[
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 40, right: 10),
              child: Divider(),
            ),
          ),
          Text(
            'Empty List',
            style: TextStyle(
                color: Theme.of(context).textTheme.caption!.color,
                fontStyle: FontStyle.italic),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 40),
              child: Divider(),
            ),
          ),
        ],
      ),
      listDecoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      listDragHandle: const DragHandle(
        verticalAlignment: DragHandleVerticalAlignment.top,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.menu,
            color: Colors.black26,
          ),
        ),
      ),
      itemDragHandle: const DragHandle(
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.menu,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _entries[oldListIndex].children.removeAt(oldItemIndex);
      _entries[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _entries.removeAt(oldListIndex);
      _entries.insert(newListIndex, movedList);
    });
  }
}

abstract class _CategoryListEntry extends StatelessWidget {
  Key get key;
}

class _CategoryListGroupEntry extends _CategoryListEntry {
  final CategoryGroup group;

  @override
  Key get key => Key('group-${group.id}');

  _CategoryListGroupEntry(this.group);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(title: Text(group.name)),
        const Divider(),
      ],
    );
  }
}

class _CategoryListCategoryEntry extends _CategoryListEntry {
  final Category category;

  @override
  Key get key => Key('category-${category.id}');

  _CategoryListCategoryEntry(this.category);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(category.name));
  }
}
