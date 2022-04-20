import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class CoverImage extends StatefulWidget {
  final ImageUri uri;
  final ImageDimension dimension;

  final double size;

  CoverImage({Key? key, required this.uri, required this.dimension, double? size})
      : size = size ?? dimension.value.toDouble(),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CoverImageState();
  }
}

class _CoverImageState extends State<CoverImage> {
  Future<Uint8List?>? _futureImage;

  void handleImage({CoverImage? oldWidget}) {
    if (oldWidget?.uri.raw == widget.uri.raw &&
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
  void didUpdateWidget(CoverImage oldWidget) {
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
              return Image.memory(
                snapshot.data!,
                width: widget.size,
                height: widget.size,
              );
            }
            if (snapshot.hasError) {
              return Icon(Icons.error_outline, size: widget.size);
            }
            return Icon(Icons.album, size: widget.size);
          }),
    );
  }
}
