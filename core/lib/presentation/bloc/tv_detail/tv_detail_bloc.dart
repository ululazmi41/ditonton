import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/remove_tv_watchlist.dart';
import 'package:core/domain/usecases/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListTvStatus getWatchListStatus;
  final SaveTvWatchlist saveWatchlist;
  final RemoveTvWatchlist removeWatchlist;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(FetchEmpty()) {
    on<FetchTvDetail>((event, emit) async {
      emit(FetchLoading());

      final detailResult = await getTvDetail.execute(event.id);
      final recommendationResult = await getTvRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(FetchError(failure.message));
        },
        (tv) {
          emit(FetchLoaded(tv));
          recommendationResult.fold(
            (failure) {
              emit(FetchRecommendationError(failure.message));
            },
            (tvs) {
              emit(FetchRecommendationLoaded(tvs));
            },
          );
        },
      );
    });

    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tv);

      await result.fold(
        (failure) async {
          emit(WatchlistMessage(failure.message));
        },
        (successMessage) async {
          emit(WatchlistMessage(successMessage));
        },
      );

      bool isAddedtoWatchlist = await _loadWatchlistStatus(event.tv.id);
      emit(IsAddedToWatchlist(isAddedtoWatchlist));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tv);

      await result.fold(
        (failure) async {
          emit(WatchlistMessage(failure.message));
        },
        (successMessage) async {
          emit(WatchlistMessage(successMessage));
        },
      );

      bool isAddedtoWatchlist = await _loadWatchlistStatus(event.tv.id);
      emit(IsAddedToWatchlist(isAddedtoWatchlist));
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(IsAddedToWatchlist(result));
    });
  }

  Future<bool> _loadWatchlistStatus(int tvId) async {
    final result = await getWatchListStatus.execute(tvId);
    return result;
  }
}
