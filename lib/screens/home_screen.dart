import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:statify/api/album.dart';
import 'package:statify/api/artist.dart';
import 'package:statify/api/track.dart';
import 'package:statify/connector.dart';
import 'package:statify/screens/home/album_screen.dart';
import 'package:statify/screens/home/artist_screen.dart';
import 'package:statify/screens/home/track_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String? _trackId;
  Widget? _homeScreen;

  Widget buildHomeScreen(BuildContext context, Track track) {
    Album album = (track.album ?? Album.fromJson({}));
    Artist artist = (track.artist ?? Artist.fromJson({}));

    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
                padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                tabs: const [
                  Tab(icon: Icon(Icons.audiotrack)),
                  Tab(icon: Icon(Icons.album)),
                  Tab(icon: Icon(Icons.person)),
                ]),
            Expanded(
                child: TabBarView(children: [
              TrackScreen(track: track),
              AlbumScreen(album: album),
              ArtistScreen(artist: artist),
            ]))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: Connector().subscribePlayerState(),
        builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
          String? trackId = snapshot.data?.track?.uri.split(':').last;

          if (trackId == null || trackId.isEmpty) {
            return const CircularProgressIndicator();
          }
          if (trackId == _trackId && _homeScreen != null) {
            return _homeScreen!;
          }
          return FutureBuilder(
              future: Track.getTrack(trackId),
              builder: (BuildContext context, AsyncSnapshot<Track> snapshot) {
                Track? track = snapshot.data;

                if (track == null) {
                  return const CircularProgressIndicator();
                }

                _trackId = track.id;
                _homeScreen = buildHomeScreen(context, track);

                return _homeScreen!;
              });
        });
  }
}
