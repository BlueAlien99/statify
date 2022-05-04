import 'package:flutter/material.dart';
import 'package:statify/api/track.dart';
import 'package:statify/widgets/data_piece.dart';
import 'package:statify/widgets/home_screen/dialog_list_button.dart';
import 'package:statify/widgets/home_screen/home_screen_tab_view.dart';
import 'package:statify/widgets/home_screen/popularity.dart';
import 'package:statify/widgets/home_screen/track_artists.dart';

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
          TrackArtists(artists: track.artists ?? []),
          DataPiece(name: 'Album', value: track.album?.name),
          DataPiece(name: 'Track / Disc', value: '${track.trackNumber} / ${track.discNumber}'),
          DataPiece(
            name: 'Available markets',
            widget: DialogListButton(
                name: 'Available markets',
                length: track.availableMarkets?.length ?? 0,
                children: [
                  Text(
                    (track.availableMarkets ?? []).join(', '),
                    textAlign: TextAlign.center,
                  )
                ]),
          ),
          DataPiece(name: 'ID', value: track.id),
          DataPiece(name: 'URI', value: track.uri),
        ]);
  }
}
