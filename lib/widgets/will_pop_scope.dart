import 'package:flutter/material.dart';

class CustomWillPopScope extends StatelessWidget {
  const CustomWillPopScope(
    this.context, {
    super.key,
    required this.child,
    this.ignore = false,
  });

  final Widget child;
  final BuildContext context;

  /// If [ignore] is true, WillPopScope will automatically pop.
  final bool ignore;

  Future<bool> _onWillPop() {
    if (ignore) {
      return Future<bool>(
        () {
          return true;
        },
      );
    }
    return showDialog<bool>(
      context: context,
      builder: _willPopDialogBuilder,
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop, child: child);
  }
}

Widget _willPopDialogBuilder(context) => AlertDialog(
      title: const Text('Leave the page?'),
      content: const Text('Progress will be lost.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('cancel')),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('leave')),
      ],
    );
