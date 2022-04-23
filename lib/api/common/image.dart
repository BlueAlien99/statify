import 'package:statify/utils/type_or.dart';

class Image {
  final String url;
  final int height;
  final int width;

  Image({required this.url, required this.height, required this.width});

  factory Image.fromJson(Map json) {
    return Image(
        url: stringOr(json['url']), height: intOr(json['height']), width: intOr(json['width']));
  }
}
