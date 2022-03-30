part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class FetchLoading extends PopularMoviesState {}

class FetchError extends PopularMoviesState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchEmpty extends PopularMoviesState {}

class FetchLoaded extends PopularMoviesState {
  final List<Movie> movies;

  const FetchLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
