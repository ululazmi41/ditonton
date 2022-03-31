part of 'tv_detail_watchlist_bloc.dart';

abstract class TvDetailWatchlistEvent extends Equatable {
  const TvDetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlist extends TvDetailWatchlistEvent {
  final int id;

  const LoadWatchlist(this.id);

  @override
  List<Object> get props => [id];
}

class AddingWatchlist extends TvDetailWatchlistEvent {
  final TvDetail tv;

  const AddingWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemovingWatchlist extends TvDetailWatchlistEvent {
  final TvDetail tv;

  const RemovingWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}
