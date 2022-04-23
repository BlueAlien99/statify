import 'package:statify/utils/type_or_null.dart';

class ExternalUrls {
  final String? spotify;

  ExternalUrls({this.spotify});

  factory ExternalUrls.fromJson(Map json) {
    return ExternalUrls(spotify: stringOrNull(json['spotify']));
  }
}
