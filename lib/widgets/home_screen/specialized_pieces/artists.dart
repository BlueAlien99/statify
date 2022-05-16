import 'package:flutter/cupertino.dart';
import 'package:statify/api/artist.dart';
import 'package:statify/widgets/home_screen/data_piece.dart';
import 'package:statify/widgets/home_screen/specialized_pieces/dialog_list_data.dart';

class Artists extends StatelessWidget {
  final List<ArtistSummary> artists;

  const Artists({Key? key, required this.artists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (artists.length > 1) {
      return Column(
        children: [
          DataPiece(name: 'Main artist', value: artists.first.name),
          DialogListData(
              name: 'Artists', children: artists.map((artist) => Text(artist.name ?? '')).toList())
        ],
      );
    }
    return DataPiece(name: 'Artist', value: artists.first.name);
  }
}
