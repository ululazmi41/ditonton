part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class FetchLoading extends TvDetailState {}

class FetchEmpty extends TvDetailState {}

class FetchLoaded extends TvDetailState {
  final TvDetail result;

  const FetchLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class FetchError extends TvDetailState {
  final String message;

  const FetchError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchRecommendationError extends TvDetailState {
  final String message;

  const FetchRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchRecommendationLoaded extends TvDetailState {
  final List<Tv> tvs;

  const FetchRecommendationLoaded(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class WatchlistMessage extends TvDetailState {
  final String message;

  const WatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class IsAddedToWatchlist extends TvDetailState {
  final bool isAddedToWatchlist;

  const IsAddedToWatchlist(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
