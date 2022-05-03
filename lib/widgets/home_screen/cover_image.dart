import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final String? url;

  const CoverImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return const SizedBox.shrink();
    }

    return FractionallySizedBox(
        widthFactor: 0.6,
        child: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(url!),
          ),
        ));
  }
}
