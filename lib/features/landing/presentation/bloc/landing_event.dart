sealed class LandingEvent {}

class GetSetStateLanding extends LandingEvent {
  final String movieId;

  GetSetStateLanding({required this.movieId});
}
