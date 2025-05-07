enum MovieCarouselTypeEnum {
  nowPlaying(title: "Now Playing"),
  popular(title: "Popular"),
  topRated(title: "Top Rated"),
  upcoming(title: "Upcoming");

  final String title;
  const MovieCarouselTypeEnum({required this.title});
}
