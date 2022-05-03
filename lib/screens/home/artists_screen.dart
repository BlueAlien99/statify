import 'package:flutter/material.dart';
import 'package:statify/api/artist.dart';
import 'package:statify/widgets/home_screen/home_screen_tab_view.dart';

class ArtistsScreen extends StatelessWidget {
  final List<Artist> artists;

  const ArtistsScreen({Key? key, required this.artists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (artists.isEmpty) {
      return const Center(child: Text('No artists found!'));
    }

    Artist artist = artists.first;

    return HomeScreenTabView(
        name: artist.name, coverImageUrl: artist.images?.first.url, children: []);
  }
}
