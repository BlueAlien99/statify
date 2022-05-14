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

String padTime(int val, int leftPadWidth) {
  return val.toString().padLeft(leftPadWidth, '0');
}

String formatTrackDuration(int ms) {
  const int msToSecondRatio = 1000;
  const int secondToMinuteRatio = 60;
  const int msToMinuteRatio = msToSecondRatio * secondToMinuteRatio;

  int minutes = (ms / msToMinuteRatio).floor();
  int seconds = ((ms / msToSecondRatio) % secondToMinuteRatio).floor();
  int milliseconds = ms % msToSecondRatio;

  return '$minutes:${padTime(seconds, 2)}.${padTime(milliseconds, 3)}';
}
