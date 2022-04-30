import 'package:flutter/material.dart';
import 'package:statify/api/track.dart';
import 'package:statify/widgets/data_piece.dart';

class TrackScreen extends StatelessWidget {
  final Track track;

  const TrackScreen({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        FractionallySizedBox(
            widthFactor: 0.6,
            child: AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(track.album!.images.first.url),
              ),
            )),
        DataPiece(
          name: 'Name',
          value: track.name,
        ),
        DataPiece(
          name: 'Album',
          value: track.album?.name,
        ),
        DataPiece(
          name: 'Artist',
          value: track.artist?.name,
        ),
        DataPiece(
          name: 'Popularity',
          value: track.popularity.toString(),
        ),
        DataPiece(
          name: 'Track number',
          value: track.trackNumber.toString(),
        ),
        DataPiece(
          name: 'Disc number',
          value: track.discNumber.toString(),
        ),
        DataPiece(
          name: 'Duration (sec)',
          value: ((track.durationMs ?? 0) / 1000).round().toString(),
        ),
        DataPiece(
          name: 'Restrictions',
          value: track.restrictions?.reason.toString(),
        ),
        DataPiece(
          name: 'Is explicit',
          value: track.explicit.toString(),
        ),
        DataPiece(
          name: 'Is playable',
          value: track.isPlayable.toString(),
        ),
        DataPiece(
          name: 'Is local',
          value: track.isLocal.toString(),
        ),
        DataPiece(
          name: 'ID',
          value: track.id,
        ),
        DataPiece(
          name: 'URI',
          value: track.uri,
        ),
        DataPiece(
          name: 'href',
          value: track.href,
        ),
        DataPiece(
          name: 'Upc',
          value: track.externalIds?.upc,
        ),
        DataPiece(
          name: 'Ean',
          value: track.externalIds?.ean,
        ),
        DataPiece(
          name: 'Isrc',
          value: track.externalIds?.isrc,
        ),
        DataPiece(
          name: 'Spotify URL',
          value: track.externalUrls?.spotify,
        ),
        DataPiece(
          name: 'Preview URL',
          value: track.previewUrl,
        ),
        DataPiece(
          name: 'Available markets',
          value: track.availableMarkets?.join(', '),
        ),
        const SizedBox(
          height: 128,
        )
      ],
    ));
  }
}
