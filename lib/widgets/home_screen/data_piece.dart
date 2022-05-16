import 'package:flutter/material.dart';

class DataPiece extends StatelessWidget {
  final String name;
  final String? value;
  final Widget? widget;
  final EdgeInsetsGeometry padding;

  const DataPiece(
      {Key? key,
      required this.name,
      this.value,
      this.widget,
      this.padding = const EdgeInsets.all(8.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (widget == null && (value == null || value == 'null' || value!.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(child: widget != null ? widget! : Text(value!, textAlign: TextAlign.end))
        ],
      ),
    );
  }
}
