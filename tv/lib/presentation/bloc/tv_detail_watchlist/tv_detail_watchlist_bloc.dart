import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv/domain/usecases/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_watchlist_event.dart';
part 'tv_detail_watchlist_state.dart';

class TvDetailWatchlistBloc
    extends Bloc<TvDetailWatchlistEvent, TvDetailWatchlistState> {
  GetWatchListTvStatus getWatchListStatus;
  SaveTvWatchlist saveWatchlist;
  RemoveTvWatchlist removeWatchlist;

  TvDetailWatchlistBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(InitialState()) {
    on<LoadWatchlist>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(WatchlistLoaded(result));
    });

    on<AddingWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tv);

      result.fold(
        (failure) {
          //
        },
        (successMessage) {
          emit(AddingWatchlistSuccess(successMessage));
        },
      );

      final bool isAdded = await getWatchListStatus.execute(event.tv.id);
      emit(WatchlistLoaded(isAdded));
    });

    on<RemovingWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tv);

      result.fold(
        (failure) {
          //
        },
        (successMessage) {
          emit(RemovingWatchlistSuccess(successMessage));
        },
      );

      final bool isAdded = await getWatchListStatus.execute(event.tv.id);
      emit(WatchlistLoaded(isAdded));
    });
  }
}
