part of 'tv_list_bloc.dart';

abstract class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object> get props => [];
}

class FetchEmpty extends TvListState {}

class FetchLoading extends TvListState {}

class FetchError extends TvListState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchLoaded extends TvListState {
  final List<Tv> tvs;

  const FetchLoaded(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class FetchPopularLoading extends TvListState {}

class FetchPopularEmpty extends TvListState {}

class FetchPopularError extends TvListState {
  final String message;

  const FetchPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchPopularLoaded extends TvListState {
  final List<Tv> tvs;

  const FetchPopularLoaded(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class FetchTopRatedLoading extends TvListState {}

class FetchTopRatedEmpty extends TvListState {}

class FetchTopRatedError extends TvListState {
  final String message;

  const FetchTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchTopRatedLoaded extends TvListState {
  final List<Tv> tvs;

  const FetchTopRatedLoaded(this.tvs);

  @override
  List<Object> get props => [tvs];
}
