import 'package:statify/api/artist.dart';
import 'package:statify/api/common/enums.dart';
import 'package:statify/api/common/external_urls.dart';
import 'package:statify/api/common/image.dart';
import 'package:statify/api/common/restrictions.dart';
import 'package:statify/utils/helpers.dart';
import 'package:statify/utils/type_or.dart';

enum AlbumType { album, single, compilation }

const albumTypeMap = {
  'album': AlbumType.album,
  'single': AlbumType.single,
  'compilation': AlbumType.compilation
};

enum AlbumGroup { album, single, compilation, appearsOn }

const albumGroupMap = {
  'album': AlbumGroup.album,
  'single': AlbumGroup.single,
  'compilation': AlbumGroup.compilation,
  'appears_on': AlbumGroup.appearsOn
};

class Album {
  final AlbumType? albumType;
  final int totalTracks;
  final List<String> availableMarkets;
  final ExternalUrls externalUrls;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final String releaseDate;
  final ReleaseDatePrecision? releaseDatePrecision;
  final Restrictions? restrictions;
  final ObjectType? objectType;
  final String uri;
  final AlbumGroup? albumGroup;
  final List<ArtistSummary> artists;

  Album(
      {this.albumType,
      required this.totalTracks,
      required this.availableMarkets,
      required this.externalUrls,
      required this.href,
      required this.id,
      required this.images,
      required this.name,
      required this.releaseDate,
      this.releaseDatePrecision,
      this.restrictions,
      this.objectType,
      required this.uri,
      this.albumGroup,
      required this.artists});

  factory Album.fromJson(Map json) {
    return Album(
        albumType: albumTypeMap[json['album_type']],
        totalTracks: intOr(json['total_tracks']),
        availableMarkets: arrayOfType(stringOr, json['available_markets']),
        externalUrls: construct(ExternalUrls.fromJson, json['external_urls']),
        href: stringOr(json['href']),
        id: stringOr(json['id']),
        images: arrayOfClass(Image.fromJson, json['images']),
        name: stringOr(json['name']),
        releaseDate: stringOr(json['release_date']),
        releaseDatePrecision: releaseDatePrecisionMap[json['release_date_precision']],
        restrictions: optionallyConstruct(Restrictions.fromJson, json['restrictions']),
        objectType: objectTypeMap[json['type']],
        uri: stringOr(json['uri']),
        albumGroup: albumGroupMap[json['album_group']],
        artists: arrayOfClass(ArtistSummary.fromJson, json['artists']));
  }
}
