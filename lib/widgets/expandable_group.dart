import 'package:flutter/material.dart';

class ExpandableGroup extends StatefulWidget {
  const ExpandableGroup(
      {super.key,
      required this.title,
      required this.children,
      this.expandedIcon = const Icon(Icons.arrow_drop_down),
      this.collapsedIcon = const Icon(Icons.arrow_right),
      this.isExpanded = true});

  final String title;
  final List<Widget> children;
  final bool isExpanded;

  final Widget expandedIcon;
  final Widget collapsedIcon;

  @override
  ExpandableGroupState createState() => ExpandableGroupState();
}

class ExpandableGroupState extends State<ExpandableGroup> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return _isExpanded ? _buildCollapsed(context) : _buildHeader();
  }

  void _setExpandedState(bool isExpanded) => setState(() {
        _isExpanded = isExpanded;
      });

  Widget _buildHeader() {
    return Ink(
      child: ListTile(
        title: Row(
          children: [
            (_isExpanded ? widget.expandedIcon : widget.collapsedIcon),
            Text(widget.title),
          ],
        ),
        contentPadding: const EdgeInsets.only(left: 0.0, right: 16.0),
        onTap: () => _setExpandedState(!_isExpanded),
      ),
    );
  }

  Widget _buildCollapsed(BuildContext context) {
    return Column(
        children: ListTile.divideTiles(tiles: [
      _buildHeader(),
      ...widget.children.map((e) => Ink(
            child: ListTile(
              title: e,
              contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
            ),
          ))
    ], context: context)
            .toList());
  }
}
