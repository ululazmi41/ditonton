part of 'top_rated_tvs_bloc.dart';

abstract class TopRatedTvsState extends Equatable {
  const TopRatedTvsState();

  @override
  List<Object> get props => [];
}

class FetchLoading extends TopRatedTvsState {}

class FetchError extends TopRatedTvsState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchEmpty extends TopRatedTvsState {}

class FetchLoaded extends TopRatedTvsState {
  final List<Tv> tvs;

  const FetchLoaded(this.tvs);

  @override
  List<Object> get props => [tvs];
}
