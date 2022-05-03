import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:statify/connector.dart';
import 'package:statify/widgets/player_cover_image.dart';
import 'package:statify/widgets/playback_progress_bar.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayerState();
  }
}

class _PlayerState extends State<Player> {
  Widget? _widget;

  void handleHorizontalDrag(DragEndDetails details) {
    double v = details.primaryVelocity ?? 0;
    if (v > 0) {
      SpotifySdk.skipPrevious();
    }
    if (v < 0) {
      SpotifySdk.skipNext();
    }
  }

  Widget buildPlayer(BuildContext context, PlayerState playerState) {
    var track = playerState.track!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onHorizontalDragEnd: handleHorizontalDrag,
        child: Container(
            height: 56,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.blueGrey,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          PlayerCoverImage(
                              uri: track.imageUri, dimension: ImageDimension.thumbnail),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    track.name,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Text(track.artist.name ?? '',
                                      softWrap: false,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        overflow: TextOverflow.fade,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: playerState.isPaused ? SpotifySdk.resume : SpotifySdk.pause,
                            icon: playerState.isPaused
                                ? const Icon(Icons.play_arrow)
                                : const Icon(Icons.pause),
                            iconSize: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            constraints: const BoxConstraints(),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),
                  PlaybackProgressBar(
                      playbackPosition: playerState.playbackPosition,
                      trackDuration: track.duration,
                      isPaused: playerState.isPaused)
                ],
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _widget ??= StreamBuilder<PlayerState>(
        stream: Connector().subscribePlayerState(),
        builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
          var playerState = snapshot.data;

          if (playerState == null || playerState.track == null) {
            return const SizedBox.shrink();
          }

          return buildPlayer(context, playerState);
        });
    return _widget!;
  }
}
