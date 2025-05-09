import 'package:filme_flix/models/movie_model.dart';

sealed class LandingState {}

class LandingStateSuccess extends LandingState {
  Movie bannerMovie;

  LandingStateSuccess({required this.bannerMovie});
}

class LandingStateLoading extends LandingState {}

class LandingStateError extends LandingState {
  final String error;

  LandingStateError({required this.error});
}

class LandingStateInitial extends LandingState {}
