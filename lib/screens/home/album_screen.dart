import 'package:flutter/material.dart';
import 'package:statify/api/album.dart';
import 'package:statify/widgets/home_screen/home_screen_tab_view.dart';

class AlbumScreen extends StatelessWidget {
  final Album album;

  const AlbumScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreenTabView(name: album.name, coverImageUrl: album.images.first.url, children: []);
  }
}
