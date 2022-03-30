part of 'popular_tvs_bloc.dart';

abstract class PopularTvsState extends Equatable {
  const PopularTvsState();

  @override
  List<Object> get props => [];
}

class FetchLoading extends PopularTvsState {}

class FetchError extends PopularTvsState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchEmpty extends PopularTvsState {}

class FetchLoaded extends PopularTvsState {
  final List<Tv> movies;

  const FetchLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
