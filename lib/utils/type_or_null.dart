int? intOrNull(dynamic val) {
  return val is int ? val : null;
}

String? stringOrNull(dynamic val) {
  return val is String ? val : null;
}

List? arrayOrNull(dynamic val) {
  return val is List ? val : null;
}

Map? mapOrNull(dynamic val) {
  return val is Map ? val : null;
}

bool? boolOrNull(dynamic val) {
  return val is bool ? val : null;
}
