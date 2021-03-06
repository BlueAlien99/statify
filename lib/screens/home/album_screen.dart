import 'package:flutter/material.dart';
import 'package:statify/api/album.dart';
import 'package:statify/widgets/home_screen/data_piece.dart';
import 'package:statify/widgets/home_screen/specialized_pieces/artists.dart';
import 'package:statify/widgets/home_screen/specialized_pieces/dialog_list_data.dart';
import 'package:statify/widgets/home_screen/specialized_pieces/url_data.dart';
import 'package:statify/widgets/home_screen_tab_view.dart';

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
          DataPiece(name: 'Album type', value: album.albumType.toString().split('.').last),
          DataPiece(name: 'Release date', value: album.releaseDate),
          DataPiece(name: 'Tracks', value: album.totalTracks.toString()),
          DataPiece(
              name: 'Restrictions', value: album.restrictions?.reason.toString().split('.').last),
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
