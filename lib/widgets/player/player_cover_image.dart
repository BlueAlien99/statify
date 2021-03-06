import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlayerCoverImage extends StatefulWidget {
  final ImageUri uri;
  final ImageDimension dimension;

  final double size;

  PlayerCoverImage({Key? key, required this.uri, required this.dimension, double? size})
      : size = size ?? dimension.value.toDouble(),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayerCoverImageState();
  }
}

class _PlayerCoverImageState extends State<PlayerCoverImage> {
  Future<Uint8List?>? _futureImage;
  bool _hasError = false;

  void handleImage({PlayerCoverImage? oldWidget}) {
    if (!_hasError &&
        oldWidget?.uri.raw == widget.uri.raw &&
        oldWidget?.dimension.value == widget.dimension.value) {
      return;
    }
    _futureImage = SpotifySdk.getImage(
      imageUri: widget.uri,
      dimension: widget.dimension,
    );
  }

  @override
  void initState() {
    super.initState();
    handleImage();
  }

  @override
  void didUpdateWidget(PlayerCoverImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    handleImage(oldWidget: oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: FutureBuilder(
          future: _futureImage,
          builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
            if (snapshot.hasData) {
              _hasError = false;
              return Image.memory(
                snapshot.data!,
                width: widget.size,
                height: widget.size,
              );
            }
            _hasError = true;
            return Icon(Icons.album, size: widget.size);
          }),
    );
  }
}
