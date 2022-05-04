import 'package:flutter/material.dart';

import '../../styles.dart';

class DialogListButton extends StatelessWidget {
  final String name;
  final List<Widget> children;
  final int? length;

  const DialogListButton({Key? key, required this.name, required this.children, this.length})
      : super(key: key);

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [...children],
            ),
            scrollable: true,
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _showDialog(context),
      child: Text('Show all (${length ?? children.length})'),
      style: slimTextButtonStyle,
    );
  }
}
