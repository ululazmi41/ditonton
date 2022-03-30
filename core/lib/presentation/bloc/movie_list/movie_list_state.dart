part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListEmpty extends MovieListState {}

class FetchLoading extends MovieListState {}

class FetchError extends MovieListState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchLoaded extends MovieListState {
  final List<Movie> movies;

  const FetchLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class FetchPopularLoading extends MovieListState {}

class FetchPopularError extends MovieListState {
  final String message;

  const FetchPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchPopularLoaded extends MovieListState {
  final List<Movie> movies;

  const FetchPopularLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class FetchTopRatedLoading extends MovieListState {}

class FetchTopRatedError extends MovieListState {
  final String message;

  const FetchTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchTopRatedLoaded extends MovieListState {
  final List<Movie> movies;

  const FetchTopRatedLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
