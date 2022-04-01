import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvs getWatchlistTvs;

  WatchlistTvBloc({required this.getWatchlistTvs}) : super(FetchEmpty()) {
    on<FetchWatchlistTvs>((event, emit) async {
      emit(FetchLoading());

      final result = await getWatchlistTvs.execute();
      result.fold(
        (failure) {
          emit(FetchError(failure.message));
        },
        (tvs) {
          if (tvs.isNotEmpty) {
            emit(FetchLoaded(tvs));
          } else {
            emit(FetchEmpty());
          }
        },
      );
    });
  }
}
