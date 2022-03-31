part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;
  final bool isAddedtoWatchlist;
  final List<Movie> recommendations;

  const MovieDetailLoaded(
      this.movie, this.isAddedtoWatchlist, this.recommendations);

  @override
  List<Object> get props => [movie, isAddedtoWatchlist, recommendations];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailRecommendationLoading extends MovieDetailState {}

class MovieDetailRecommendationEmpty extends MovieDetailState {}

class MovieDetailRecommendationError extends MovieDetailState {
  final String message;

  const MovieDetailRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailRecommendationLoaded extends MovieDetailState {
  final List<Movie> recommendations;

  const MovieDetailRecommendationLoaded(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}

class MovieDetailErrorRecommendation extends MovieDetailState {
  final MovieDetail movie;
  final bool isAddedtoWatchlist;
  final String message;

  const MovieDetailErrorRecommendation(
      this.movie, this.isAddedtoWatchlist, this.message);

  @override
  List<Object> get props => [movie, isAddedtoWatchlist, message];
}
