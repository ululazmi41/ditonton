part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  const TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMoviesEmpty extends TopRatedMoviesState {}

class TopRatedMoviesLoaded extends TopRatedMoviesState {
  final List<Movie> movies;

  const TopRatedMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
