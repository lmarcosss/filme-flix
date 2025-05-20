import 'package:filme_flix/core/models/movie_model.dart';

sealed class LandingState {}

class LandingStateSuccess extends LandingState {
  MovieModel bannerMovie;

  LandingStateSuccess({required this.bannerMovie});
}

class LandingStateLoading extends LandingState {}

class LandingStateError extends LandingState {
  final String message;

  LandingStateError({required this.message});
}

class LandingStateInitial extends LandingState {}
