import 'package:flutter/material.dart';
import 'package:statify/widgets/player.dart';

class Navbar extends StatelessWidget {
  final midColor = const Color.fromRGBO(0, 0, 0, 0.5);

  final int idx;
  final void Function(int) setIdx;

  const Navbar({Key? key, required this.idx, required this.setIdx}) : super(key: key);

  Widget buildNavbar(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.library_music_outlined), label: 'Your Library'),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedFontSize: Theme.of(context).textTheme.labelMedium?.fontSize ?? 12,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      currentIndex: idx,
      onTap: setIdx,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [midColor, Colors.transparent])),
          child: Player(),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, midColor])),
          child: buildNavbar(context),
        ),
      ],
    );
  }
}
