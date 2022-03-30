import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());

      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          emit(MovieDetailLoaded(movie));
          recommendationResult.fold(
            (failure) {
              emit(MovieDetailRecommendationError(failure.message));
            },
            (movies) {
              emit(MovieDetailRecommendationLoaded(movies));
            },
          );
        },
      );
    });

    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);

      await result.fold(
        (failure) async {
          emit(AddWatchlistMessage(failure.message));
        },
        (successMessage) async {
          emit(AddWatchlistMessage(successMessage));
        },
      );

      bool isAddedtoWatchlist = await _loadWatchlistStatus(event.movie.id);
      emit(IsAddedToWatchlist(isAddedtoWatchlist));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);

      await result.fold(
        (failure) async {
          emit(AddWatchlistMessage(failure.message));
        },
        (successMessage) async {
          emit(AddWatchlistMessage(successMessage));
        },
      );

      bool isAddedtoWatchlist = await _loadWatchlistStatus(event.movie.id);
      emit(IsAddedToWatchlist(isAddedtoWatchlist));
    });
  }

  Future<bool> _loadWatchlistStatus(int movieId) async {
    final result = await getWatchListStatus.execute(movieId);
    return result;
  }
}
