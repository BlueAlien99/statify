import 'package:flutter/cupertino.dart';
import 'package:statify/api/artist.dart';
import 'package:statify/widgets/data_piece.dart';
import 'package:statify/widgets/home_screen/dialog_list_button.dart';

class Artists extends StatelessWidget {
  final List<ArtistSummary> artists;

  const Artists({Key? key, required this.artists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (artists.length > 1) {
      return Column(
        children: [
          DataPiece(name: 'Main artist', value: artists.first.name),
          DataPiece(
            name: 'Artists',
            widget: DialogListButton(
                name: 'Artists',
                children: artists.map((artist) => Text(artist.name ?? '')).toList()),
          )
        ],
      );
    }
    return DataPiece(name: 'Artist', value: artists.first.name);
  }
}
