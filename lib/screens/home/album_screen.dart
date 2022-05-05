import 'package:flutter/material.dart';
import 'package:statify/api/album.dart';
import 'package:statify/widgets/data_piece.dart';
import 'package:statify/widgets/home_screen/artists.dart';
import 'package:statify/widgets/home_screen/dialog_list_data.dart';
import 'package:statify/widgets/home_screen/home_screen_tab_view.dart';
import 'package:statify/widgets/home_screen/url_data.dart';

class AlbumScreen extends StatelessWidget {
  final Album album;

  const AlbumScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreenTabView(
        name: album.name,
        coverImageUrl: album.images.first.url,
        coverImagePlaceholder: const Icon(Icons.album),
        children: [
          Artists(artists: album.artists),
          DataPiece(name: 'Tracks', value: album.totalTracks.toString()),
          DialogListData(
              name: 'Images',
              children: album.images
                  .map((image) => UrlData(name: '${image.width}x${image.height}', value: image.url))
                  .toList()),
          DialogListData(
              name: 'Available markets',
              length: album.availableMarkets.length,
              children: [Text(album.availableMarkets.join(', '), textAlign: TextAlign.center)]),
          UrlData(name: 'Spotify URL', value: album.externalUrls.spotify),
          UrlData(name: 'API URL', value: album.href, canOpen: false),
          DataPiece(name: 'ID', value: album.id),
          DataPiece(name: 'URI', value: album.uri),
        ]);
  }
}
