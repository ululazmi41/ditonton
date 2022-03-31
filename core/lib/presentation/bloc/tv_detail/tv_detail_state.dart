part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailLoading extends TvDetailState {}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvDetail tv;
  final bool isAddedtoWatchlist;
  final List<Tv> recommendations;

  const TvDetailLoaded(this.tv, this.isAddedtoWatchlist, this.recommendations);

  @override
  List<Object> get props => [tv, isAddedtoWatchlist, recommendations];
}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailErrorRecommendation extends TvDetailState {
  final TvDetail tv;
  final bool isAddedtoWatchlist;
  final String message;

  const TvDetailErrorRecommendation(
      this.tv, this.isAddedtoWatchlist, this.message);

  @override
  List<Object> get props => [tv, isAddedtoWatchlist, message];
}

class TvDetailRecommendationLoading extends TvDetailState {}

class TvDetailRecommendationError extends TvDetailState {
  final String message;

  const TvDetailRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailRecommendationLoaded extends TvDetailState {
  final List<Tv> tvs;

  const TvDetailRecommendationLoaded(this.tvs);

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

class AddWatchlistSuccess extends TvDetailState {
  final String message;

  const AddWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddWatchlistFailed extends TvDetailState {}

class RemoveWatchlistSuccess extends TvDetailState {
  final String message;

  const RemoveWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveWatchlistFailed extends TvDetailState {}
