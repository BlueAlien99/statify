import 'package:flutter/material.dart';
import 'package:statify/widgets/data_piece.dart';

class Popularity extends StatelessWidget {
  final int? value;

  const Popularity({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return const SizedBox.shrink();
    }

    double valueFraction = value! / 100;

    HSLColor red = HSLColor.fromColor(Colors.red);
    HSLColor green = HSLColor.fromColor(Colors.green);
    double hue = red.hue + (green.hue - red.hue) * valueFraction;
    Color color = red.withHue(hue).toColor();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataPiece(
            name: 'Popularity',
            value: value!.toString(),
            padding: const EdgeInsets.only(bottom: 6),
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: double.infinity,
                color: Colors.white10,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: valueFraction,
                  child: SizedBox(
                    height: 8,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: color),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
