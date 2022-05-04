import 'package:flutter/material.dart';
import 'package:statify/api/artist.dart';
import 'package:statify/utils/formatters.dart';
import 'package:statify/widgets/data_piece.dart';
import 'package:statify/widgets/home_screen/dialog_list_button.dart';
import 'package:statify/widgets/home_screen/home_screen_tab_view.dart';
import 'package:statify/widgets/home_screen/popularity.dart';
import 'package:statify/widgets/home_screen/url_data.dart';

class ArtistsScreen extends StatelessWidget {
  final List<Artist> artists;

  const ArtistsScreen({Key? key, required this.artists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (artists.isEmpty) {
      return const Center(child: Text('No artists found!'));
    }

    Artist artist = artists.first;

    return HomeScreenTabView(name: artist.name, coverImageUrl: artist.images?.first.url, children: [
      Popularity(value: artist.popularity),
      DataPiece(name: 'Followers', value: formatLongInt(artist.followers?.total)),
      DataPiece(
        name: 'Genres',
        widget: DialogListButton(
            name: 'Genres', children: (artist.genres ?? []).map((genre) => Text(genre)).toList()),
      ),
      UrlData(name: 'Spotify URL', value: artist.externalUrls?.spotify),
      UrlData(name: 'API URL', value: artist.href, canOpen: false),
      DataPiece(name: 'ID', value: artist.id),
      DataPiece(name: 'URI', value: artist.uri),
    ]);
  }
}
