class ImageTmdb {
  static const String w92 = 'w92';
  static const String w154 = 'w154';
  static const String w185 = 'w185';
  static const String w342 = 'w342';
  static const String w500 = 'w500';
  static const String w780 = 'w780';
  static const String original = 'original';

  static String getImageUrl(String path, {String size = original}) {
    return "https://image.tmdb.org/t/p/$size$path";
  }
}
