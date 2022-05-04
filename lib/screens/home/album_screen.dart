import 'package:flutter/material.dart';
import 'package:statify/api/album.dart';
import 'package:statify/widgets/data_piece.dart';
import 'package:statify/widgets/home_screen/dialog_list_button.dart';
import 'package:statify/widgets/home_screen/home_screen_tab_view.dart';

class AlbumScreen extends StatelessWidget {
  final Album album;

  const AlbumScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreenTabView(name: album.name, coverImageUrl: album.images.first.url, children: [
      DataPiece(
        name: 'Available markets',
        widget: DialogListButton(
            name: 'Available markets',
            length: album.availableMarkets.length,
            children: [Text(album.availableMarkets.join(', '), textAlign: TextAlign.center)]),
      ),
      DataPiece(name: 'ID', value: album.id),
      DataPiece(name: 'URI', value: album.uri),
    ]);
  }
}
