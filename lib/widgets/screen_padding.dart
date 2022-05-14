import 'package:flutter/material.dart';
import 'package:statify/widgets/player.dart';

class ScreenPadding extends StatelessWidget {
  const ScreenPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: kBottomNavigationBarHeight + Player.playerHeight + (2 * Player.playerMargin));
  }
}
