part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistState extends Equatable {
  const MovieDetailWatchlistState();

  @override
  List<Object> get props => [];
}

class InitialState extends MovieDetailWatchlistState {}

class WatchlistLoaded extends MovieDetailWatchlistState {
  final bool isAdded;

  const WatchlistLoaded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class AddingWatchlistSuccess extends MovieDetailWatchlistState {
  final String message;

  const AddingWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RemovingWatchlistSuccess extends MovieDetailWatchlistState {
  final String message;

  const RemovingWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}
