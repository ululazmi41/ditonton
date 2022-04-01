import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_watchlist_event.dart';
part 'movie_detail_watchlist_state.dart';

class MovieDetailWatchlistBloc
    extends Bloc<MovieDetailWatchlistEvent, MovieDetailWatchlistState> {
  GetWatchListStatus getWatchListStatus;
  SaveWatchlist saveWatchlist;
  RemoveWatchlist removeWatchlist;

  MovieDetailWatchlistBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(InitialState()) {
    on<LoadWatchlist>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(WatchlistLoaded(result));
    });

    on<AddingWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          //
        },
        (successMessage) {
          emit(AddingWatchlistSuccess(successMessage));
        },
      );

      final bool isAdded = await getWatchListStatus.execute(event.movie.id);
      emit(WatchlistLoaded(isAdded));
    });

    on<RemovingWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          //
        },
        (successMessage) {
          emit(RemovingWatchlistSuccess(successMessage));
        },
      );

      final bool isAdded = await getWatchListStatus.execute(event.movie.id);
      emit(WatchlistLoaded(isAdded));
    });
  }
}
