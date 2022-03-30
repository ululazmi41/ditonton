part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class FetchLoading extends WatchlistTvState {}

class FetchEmpty extends WatchlistTvState {}

class FetchLoaded extends WatchlistTvState {
  final List<Tv> tvs;

  const FetchLoaded(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class FetchError extends WatchlistTvState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object> get props => [message];
}
