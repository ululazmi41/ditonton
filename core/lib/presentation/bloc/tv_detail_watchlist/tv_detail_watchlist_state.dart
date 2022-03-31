part of 'tv_detail_watchlist_bloc.dart';

abstract class TvDetailWatchlistState extends Equatable {
  const TvDetailWatchlistState();

  @override
  List<Object> get props => [];
}

class InitialState extends TvDetailWatchlistState {}

class WatchlistLoaded extends TvDetailWatchlistState {
  final bool isAdded;

  const WatchlistLoaded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class AddingWatchlistSuccess extends TvDetailWatchlistState {
  final String message;

  const AddingWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RemovingWatchlistSuccess extends TvDetailWatchlistState {
  final String message;

  const RemovingWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}
