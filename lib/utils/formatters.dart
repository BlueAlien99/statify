List<String> splitByGroupsOf(int groupSize, String str, [bool reverse = false]) {
  if (str.length <= groupSize) {
    return [str];
  }
  return reverse
      ? [
          ...splitByGroupsOf(groupSize, str.substring(0, str.length - groupSize), reverse),
          str.substring(str.length - groupSize)
        ]
      : [
          str.substring(0, groupSize),
          ...splitByGroupsOf(groupSize, str.substring(groupSize), reverse)
        ];
}

String formatLongInt(int? value) {
  if (value == null) {
    return value.toString();
  }
  return splitByGroupsOf(3, value.toString(), true).join(' ');
}
