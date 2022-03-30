part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class FetchLoading extends TopRatedMoviesState {}

class FetchError extends TopRatedMoviesState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchEmpty extends TopRatedMoviesState {}

class FetchLoaded extends TopRatedMoviesState {
  final List<Movie> movies;

  const FetchLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
