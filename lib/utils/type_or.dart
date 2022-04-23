int intOr(dynamic val, {int fallback = 0}) {
  return val is int ? val : fallback;
}

String stringOr(dynamic val, {String fallback = ''}) {
  return val is String ? val : fallback;
}

List arrayOr(dynamic val, {List fallback = const []}) {
  return val is List ? val : fallback;
}

Map mapOr(dynamic val, {Map fallback = const {}}) {
  return val is Map ? val : fallback;
}
