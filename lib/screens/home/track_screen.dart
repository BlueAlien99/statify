import 'package:flutter/material.dart';
import 'package:statify/api/track.dart';
import 'package:statify/widgets/data_piece.dart';
import 'package:statify/widgets/home_screen/dialog_list_data.dart';
import 'package:statify/widgets/home_screen/home_screen_tab_view.dart';
import 'package:statify/widgets/home_screen/popularity.dart';
import 'package:statify/widgets/home_screen/artists.dart';
import 'package:statify/widgets/home_screen/url_data.dart';

class TrackScreen extends StatelessWidget {
  final Track track;

  const TrackScreen({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreenTabView(
        name: track.name,
        coverImageUrl: track.album?.images.first.url,
        children: [
          Popularity(value: track.popularity),
          Artists(artists: track.artists ?? []),
          DataPiece(name: 'Album', value: track.album?.name),
          DataPiece(name: 'Track / Disc', value: '${track.trackNumber} / ${track.discNumber}'),
          DialogListData(
              name: 'Available markets',
              length: track.availableMarkets?.length ?? 0,
              children: [
                Text((track.availableMarkets ?? []).join(', '), textAlign: TextAlign.center)
              ]),
          UrlData(name: 'Preview URL', value: track.previewUrl),
          UrlData(name: 'Spotify URL', value: track.externalUrls?.spotify),
          UrlData(name: 'API URL', value: track.href, canOpen: false),
          DataPiece(name: 'ID', value: track.id),
          DataPiece(name: 'URI', value: track.uri),
        ]);
  }
}
