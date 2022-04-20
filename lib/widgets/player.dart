import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:statify/widgets/cover_image.dart';

class Player extends StatelessWidget {
  const Player({Key? key}) : super(key: key);

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
    double progress = playerState.playbackPosition / track.duration;

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
                          CoverImage(uri: track.imageUri, dimension: ImageDimension.thumbnail),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    track.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(track.artist.name ?? '',
                                      style: const TextStyle(color: Colors.white54)),
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
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white38,
                    width: double.infinity,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: const SizedBox(
                        height: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: SpotifySdk.subscribePlayerState(),
        builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
          var playerState = snapshot.data;

          if (playerState == null || playerState.track == null) {
            return const SizedBox.shrink();
          }

          return buildPlayer(context, playerState);
        });
  }
}
