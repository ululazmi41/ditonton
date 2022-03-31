part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistEvent extends Equatable {
  const MovieDetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlist extends MovieDetailWatchlistEvent {
  final int id;

  const LoadWatchlist(this.id);

  @override
  List<Object> get props => [id];
}

class AddingWatchlist extends MovieDetailWatchlistEvent {
  final MovieDetail movie;

  const AddingWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemovingWatchlist extends MovieDetailWatchlistEvent {
  final MovieDetail movie;

  const RemovingWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}
