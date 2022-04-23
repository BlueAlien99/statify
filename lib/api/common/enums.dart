enum ObjectType { album, artist, track }

const objectTypeMap = {
  'album': ObjectType.album,
  'artist': ObjectType.artist,
  'track': ObjectType.track
};

enum ReleaseDatePrecision { year, month, day }

const releaseDatePrecisionMap = {
  'year': ReleaseDatePrecision.year,
  'month': ReleaseDatePrecision.month,
  'day': ReleaseDatePrecision.day
};
