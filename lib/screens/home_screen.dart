import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:statify/api/album.dart';
import 'package:statify/api/artist.dart';
import 'package:statify/api/track.dart';
import 'package:statify/connector.dart';
import 'package:statify/screens/home/album_screen.dart';
import 'package:statify/screens/home/artists_screen.dart';
import 'package:statify/screens/home/track_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  static const List<Tab> tabs = [
    Tab(icon: Icon(Icons.audiotrack)),
    Tab(icon: Icon(Icons.album)),
    Tab(icon: Icon(Icons.person)),
  ];

  String? _trackId;
  Widget? _homeScreen;
  late TabController _tabController;

  Future<_TrackWithArtists> fetchData(String trackId) async {
    Track track = await Track.getTrack(trackId);
    List<Artist> artists = await Artist.getSeveralArtists(
        (track.artists ?? []).map((artist) => artist.id).whereType<String>().toList());
    return _TrackWithArtists(track: track, artists: artists);
  }

  Widget buildHomeScreen(BuildContext context, _TrackWithArtists data) {
    Album album = (data.track.album ?? Album.fromJson({}));

    return Column(children: [
      TabBar(
        controller: _tabController,
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        tabs: tabs,
      ),
      Expanded(
          child: TabBarView(
        controller: _tabController,
        children: [
          TrackScreen(track: data.track),
          AlbumScreen(album: album),
          ArtistsScreen(artists: data.artists),
        ],
      ))
    ]);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              future: fetchData(trackId),
              builder: (BuildContext context, AsyncSnapshot<_TrackWithArtists> snapshot) {
                _TrackWithArtists? data = snapshot.data;

                if (data == null) {
                  return const CircularProgressIndicator();
                }

                _trackId = data.track.id;
                _homeScreen = buildHomeScreen(context, data);

                return _homeScreen!;
              });
        });
  }
}

class _TrackWithArtists {
  Track track;
  List<Artist> artists;

  _TrackWithArtists({required this.track, required this.artists});
}
