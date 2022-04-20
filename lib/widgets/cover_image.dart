import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class CoverImage extends StatelessWidget {
  final ImageUri uri;
  final ImageDimension dimension;

  final double size;

  CoverImage({Key? key, required this.uri, required this.dimension, double? size})
      : size = size ?? dimension.value.toDouble(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: FutureBuilder(
          future: SpotifySdk.getImage(
            imageUri: uri,
            dimension: dimension,
          ),
          builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
            if (snapshot.hasData) {
              return Image.memory(
                snapshot.data!,
                width: size,
                height: size,
              );
            }
            if (snapshot.hasError) {
              return Icon(Icons.error_outline, size: size);
            }
            return Icon(Icons.album, size: size);
          }),
    );
  }
}
