import 'package:statify/utils/type_or_null.dart';

class ExternalIds {
  final String? isrc;
  final String? ean;
  final String? upc;

  ExternalIds({this.isrc, this.ean, this.upc});

  factory ExternalIds.fromJson(Map json) {
    return ExternalIds(
        isrc: stringOrNull(json['isrc']),
        ean: stringOrNull(json['ean']),
        upc: stringOrNull(json['upc']));
  }
}
