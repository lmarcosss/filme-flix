enum MovieCarouselTypeEnum {
  nowPlaying(title: "Now Playing", endpoint: "now_playing"),
  popular(title: "Popular", endpoint: "popular"),
  topRated(title: "Top Rated", endpoint: "top_rated"),
  upcoming(title: "Upcoming", endpoint: "upcoming");

  final String title;
  final String endpoint;
  const MovieCarouselTypeEnum({required this.title, required this.endpoint});
}
