import 'dart:convert';

import 'package:statify/api/common/enums.dart';
import 'package:statify/api/common/external_urls.dart';
import 'package:statify/api/common/followers.dart';
import 'package:statify/api/common/image.dart';
import 'package:statify/api/utils.dart';
import 'package:statify/utils/helpers.dart';
import 'package:statify/utils/type_or.dart';
import 'package:statify/utils/type_or_null.dart';

class ArtistSummary {
  final ExternalUrls? externalUrls;
  final String? href;
  final String? id;
  final String? name;
  final ObjectType? objectType;
  final String? uri;

  ArtistSummary({this.externalUrls, this.href, this.id, this.name, this.objectType, this.uri});

  ArtistSummary.fromJson(Map json)
      : externalUrls = optionallyConstruct(ExternalUrls.fromJson, json['external_urls']),
        href = stringOrNull(json['href']),
        id = stringOrNull(json['id']),
        name = stringOrNull(json['name']),
        objectType = objectTypeMap[json['type']],
        uri = stringOrNull(json['uri']);
}

class Artist extends ArtistSummary {
  final Followers? followers;
  final List<String>? genres;
  final List<Image>? images;
  final int? popularity;

  Artist(Map json, {this.followers, this.genres, this.images, this.popularity})
      : super.fromJson(json);

  factory Artist.fromJson(Map json) {
    return Artist(json,
        followers: optionallyConstruct(Followers.fromJson, json['followers']),
        genres: optionalArrayOfType(stringOr, json['genres']),
        images: optionalArrayOfClass(Image.fromJson, json['images']),
        popularity: intOrNull(json['popularity']));
  }

  static Future<List<Artist>> getSeveralArtists(List<String> ids) async {
    final response = await apiGet('/artists?ids=${ids.join(',')}');

    if (response.statusCode == 200) {
      return arrayOfClass(Artist.fromJson, jsonDecode(response.body)['artists']);
    } else {
      throw Exception('Failed to load artists');
    }
  }
}
