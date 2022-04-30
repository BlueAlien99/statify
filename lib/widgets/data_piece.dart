import 'package:flutter/material.dart';

class DataPiece extends StatelessWidget {
  final String name;
  final String? value;

  const DataPiece({Key? key, required this.name, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == null || value == 'null' || value!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
              child: Text(
            value!,
            textAlign: TextAlign.end,
          ))
        ],
      ),
    );
  }
}
