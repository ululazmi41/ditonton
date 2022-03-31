part of 'popular_tvs_bloc.dart';

abstract class PopularTvsState extends Equatable {
  const PopularTvsState();

  @override
  List<Object> get props => [];
}

class PopularTvsLoading extends PopularTvsState {}

class PopularTvsError extends PopularTvsState {
  final String message;

  const PopularTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvsEmpty extends PopularTvsState {}

class PopularTvsLoaded extends PopularTvsState {
  final List<Tv> tvs;

  const PopularTvsLoaded(this.tvs);

  @override
  List<Object> get props => [tvs];
}
