import 'package:flutter/material.dart';
import 'package:statify/api/track.dart';

class TrackScreen extends StatelessWidget {
  final Track track;

  const TrackScreen({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${track.name}'),
      ],
    );
  }
}
