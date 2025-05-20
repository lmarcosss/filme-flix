import 'package:filme_flix/core/models/movie_model.dart';

sealed class BannerState {}

class BannerStateSuccess extends BannerState {
  final MovieModel movie;

  BannerStateSuccess({required this.movie});
}

class BannerStateLoading extends BannerState {}

class BannerStateError extends BannerState {
  final String message;

  BannerStateError({required this.message});
}

class BannerStateInitial extends BannerState {}
