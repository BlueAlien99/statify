import 'dart:convert';

import 'package:statify/api/album.dart';
import 'package:statify/api/artist.dart';
import 'package:statify/api/common/enums.dart';
import 'package:statify/api/common/external_ids.dart';
import 'package:statify/api/common/external_urls.dart';
import 'package:statify/api/common/restrictions.dart';
import 'package:statify/api/utils.dart';
import 'package:statify/utils/helpers.dart';
import 'package:statify/utils/type_or.dart';
import 'package:statify/utils/type_or_null.dart';

class Track {
  static final Map<String, Track> _cache = {};

  final Album? album;
  final List<ArtistSummary>? artists;
  final List<String>? availableMarkets;
  final int? discNumber;
  final int? durationMs;
  final bool? explicit;
  final ExternalIds? externalIds;
  final ExternalUrls? externalUrls;
  final String? href;
  final String? id;
  final bool? isPlayable;
  final Restrictions? restrictions;
  final String? name;
  final int? popularity;
  final String? previewUrl;
  final int? trackNumber;
  final ObjectType? objectType;
  final String? uri;
  final bool? isLocal;

  Track(
      {this.album,
      this.artists,
      this.availableMarkets,
      this.discNumber,
      this.durationMs,
      this.explicit,
      this.externalIds,
      this.externalUrls,
      this.href,
      this.id,
      this.isPlayable,
      this.restrictions,
      this.name,
      this.popularity,
      this.previewUrl,
      this.trackNumber,
      this.objectType,
      this.uri,
      this.isLocal});

  factory Track.fromJson(Map json) {
    return Track(
        album: optionallyConstruct(Album.fromJson, json['album']),
        artists: optionalArrayOfClass(ArtistSummary.fromJson, json['artists']),
        availableMarkets: optionalArrayOfType(stringOr, json['available_markets']),
        discNumber: intOrNull(json['disc_number']),
        durationMs: intOrNull(json['duration_ms']),
        explicit: boolOrNull(json['explicit']),
        externalIds: optionallyConstruct(ExternalIds.fromJson, json['external_ids']),
        externalUrls: optionallyConstruct(ExternalUrls.fromJson, json['external_urls']),
        href: stringOrNull(json['href']),
        id: stringOrNull(json['id']),
        isPlayable: boolOrNull(json['is_playable']),
        restrictions: optionallyConstruct(Restrictions.fromJson, json['restrictions']),
        name: stringOrNull(json['name']),
        popularity: intOrNull(json['popularity']),
        previewUrl: stringOrNull(json['preview_url']),
        trackNumber: intOrNull(json['track_number']),
        objectType: objectTypeMap[json['type']],
        uri: stringOrNull(json['uri']),
        isLocal: boolOrNull(json['is_local']));
  }

  static Future<Track> getTrack(String id) async {
    if (_cache.containsKey(id)) {
      return _cache[id]!;
    }

    final response = await apiGet('/tracks/$id');

    if (response.statusCode == 200) {
      Track track = Track.fromJson(jsonDecode(response.body));
      _cache[id] = track;
      return track;
    } else {
      throw Exception('Failed to load track');
    }
  }
}
