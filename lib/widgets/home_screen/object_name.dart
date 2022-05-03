import 'package:flutter/material.dart';

class ObjectName extends StatelessWidget {
  final String? name;

  const ObjectName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                  child: Text(
                name ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ))
            ]));
  }
}
