import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CoverImage extends StatelessWidget {
  final String? url;
  final Icon placeholder;

  const CoverImage({Key? key, this.url, required this.placeholder}) : super(key: key);

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
              padding: const EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [Expanded(child: FittedBox(fit: BoxFit.fill, child: placeholder))],
                  ),
                  FadeInImage.memoryNetwork(
                    fadeInDuration: const Duration(milliseconds: 300),
                    placeholder: kTransparentImage,
                    image: url!,
                  ),
                ],
              )),
        ));
  }
}
