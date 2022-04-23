import 'package:statify/utils/type_or_null.dart';

class Followers {
  final String? href;
  final int? total;

  Followers({this.href, this.total});

  factory Followers.fromJson(Map json) {
    return Followers(href: stringOrNull(json['href']), total: intOrNull(json['total']));
  }
}
