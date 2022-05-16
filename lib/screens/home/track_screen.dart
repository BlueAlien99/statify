import 'package:flutter/material.dart';
import 'package:statify/api/track.dart';
import 'package:statify/utils/formatters.dart';
import 'package:statify/widgets/home_screen/data_piece.dart';
import 'package:statify/widgets/home_screen/specialized_pieces/artists.dart';
import 'package:statify/widgets/home_screen/specialized_pieces/dialog_list_data.dart';
import 'package:statify/widgets/home_screen/specialized_pieces/popularity.dart';
import 'package:statify/widgets/home_screen/specialized_pieces/url_data.dart';
import 'package:statify/widgets/home_screen_tab_view.dart';

class TrackScreen extends StatelessWidget {
  final Track track;

  const TrackScreen({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreenTabView(
        name: track.name,
        coverImageUrl: track.album?.images.first.url,
        coverImagePlaceholder: const Icon(Icons.audiotrack),
        children: [
          Popularity(value: track.popularity),
          Artists(artists: track.artists ?? []),
          DataPiece(name: 'Album', value: track.album?.name),
          DataPiece(name: 'Track / Disc', value: '${track.trackNumber} / ${track.discNumber}'),
          DataPiece(name: 'Duration', value: formatTrackDuration(track.durationMs ?? 0)),
          DataPiece(name: 'Explicit', value: track.explicit.toString()),
          DataPiece(
              name: 'Restrictions', value: track.restrictions?.reason.toString().split('.').last),
          DialogListData(
              name: 'Available markets',
              length: track.availableMarkets?.length ?? 0,
              children: [
                Text((track.availableMarkets ?? []).join(', '), textAlign: TextAlign.center)
              ]),
          UrlData(name: 'Preview URL', value: track.previewUrl),
          UrlData(name: 'Spotify URL', value: track.externalUrls?.spotify),
          UrlData(name: 'API URL', value: track.href, canOpen: false),
          DataPiece(name: 'ISRC', value: track.externalIds?.isrc),
          DataPiece(name: 'EAN', value: track.externalIds?.ean),
          DataPiece(name: 'UPC', value: track.externalIds?.upc),
          DataPiece(name: 'ID', value: track.id),
          DataPiece(name: 'URI', value: track.uri),
        ]);
  }
}
