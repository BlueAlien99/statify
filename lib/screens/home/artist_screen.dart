import 'package:flutter/material.dart';
import 'package:statify/api/artist.dart';

class ArtistScreen extends StatelessWidget {
  final Artist artist;

  const ArtistScreen({Key? key, required this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Artist'),
    );
  }
}
