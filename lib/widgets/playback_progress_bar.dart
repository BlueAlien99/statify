import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class PlaybackProgressBar extends StatefulWidget {
  final int playbackPosition;
  final int trackDuration;
  final bool isPaused;

  const PlaybackProgressBar(
      {Key? key,
      required this.playbackPosition,
      required this.trackDuration,
      required this.isPaused})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlaybackProgressBarState();
  }
}

class _PlaybackProgressBarState extends State<PlaybackProgressBar> {
  static const int tickDuration = 1000;

  int _currentPlaybackPosition = 0;
  Timer? _timer;

  @override
  void didUpdateWidget(PlaybackProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentPlaybackPosition = widget.playbackPosition;
    bool isTimerActive = _timer?.isActive ?? false;
    if (!widget.isPaused && !isTimerActive) {
      _timer = Timer.periodic(const Duration(milliseconds: tickDuration), (timer) {
        setState(() {
          _currentPlaybackPosition += tickDuration;
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double progress = min(_currentPlaybackPosition / widget.trackDuration, 1);

    return Container(
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
    );
  }
}
