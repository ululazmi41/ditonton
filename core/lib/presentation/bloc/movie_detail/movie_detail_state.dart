part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail result;

  const MovieDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailRecommendationError extends MovieDetailState {
  final String message;

  const MovieDetailRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailRecommendationLoaded extends MovieDetailState {
  final List<Movie> movies;

  const MovieDetailRecommendationLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class AddWatchlistMessage extends MovieDetailState {
  final String message;

  const AddWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class IsAddedToWatchlist extends MovieDetailState {
  final bool isAddedToWatchlist;

  const IsAddedToWatchlist(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
