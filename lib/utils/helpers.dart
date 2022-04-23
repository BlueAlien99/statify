import 'package:statify/utils/type_or.dart';
import 'package:statify/utils/type_or_null.dart';

List<T> arrayOfType<T>(T Function(dynamic) ensureType, dynamic val) {
  return arrayOr(val).map(ensureType).toList();
}

List<T>? optionalArrayOfType<T>(T Function(dynamic) ensureType, dynamic val) {
  return arrayOrNull(val) == null ? null : arrayOfType(ensureType, val);
}

T construct<T>(T Function(Map) fromJson, dynamic val) {
  return fromJson(mapOr(val));
}

T? optionallyConstruct<T>(T Function(Map) fromJson, dynamic val) {
  return mapOrNull(val) == null ? null : fromJson(val);
}

List<T> arrayOfClass<T>(T Function(Map) fromJson, dynamic val) {
  return arrayOfType(mapOr, val).map(fromJson).toList();
}

List<T>? optionalArrayOfClass<T>(T Function(Map) fromJson, dynamic val) {
  return arrayOrNull(val) == null ? null : arrayOfClass(fromJson, val);
}
