sealed class MovieCarouselEvent {}

class GetSetStateMovieCarousel extends MovieCarouselEvent {
  final bool isLoadMore;

  GetSetStateMovieCarousel({
    this.isLoadMore = false,
  });
}
