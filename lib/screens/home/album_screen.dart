import 'package:flutter/material.dart';
import 'package:statify/api/album.dart';

class AlbumScreen extends StatelessWidget {
  final Album album;

  const AlbumScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Album'),
    );
  }
}
