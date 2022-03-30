part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class FetchLoading extends WatchlistMovieState {}

class FetchEmpty extends WatchlistMovieState {}

class FetchLoaded extends WatchlistMovieState {
  final List<Movie> movies;

  const FetchLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class FetchError extends WatchlistMovieState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object> get props => [message];
}
