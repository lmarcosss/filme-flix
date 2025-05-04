sealed class BannerEvent {}

class GetSetStateBanner extends BannerEvent {
  final String movieId;

  GetSetStateBanner({
    required this.movieId,
  });
}
