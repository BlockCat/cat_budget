import 'package:flutter/material.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  const ExpandableFab(
      {super.key,
      this.initialOpen,
      required this.distance,
      required this.children});

  @override
  State<StatefulWidget> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _open = false;

  late final AnimationController _controller;

  late final CurvedAnimation _expandAnimation;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
  }

  void _toggle() {
    setState(() {
      _open = !_open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            _buildTapToCloseFab(),
            _buildTapToOpenFab(),
          ]),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.close, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform:
            Matrix4.diagonal3Values(_open ? 0.7 : 1.0, _open ? 0.7 : 1.0, 1.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.new_label_rounded),
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? tooltip;
  final Widget icon;

  const ActionButton(
      {super.key, this.onPressed, this.tooltip, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: theme.colorScheme.secondary,
        elevation: 4.0,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          color: theme.colorScheme.onSecondary,
        ));
  }
}
