import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_recommendation_event.dart';
part 'tv_detail_recommendation_state.dart';

class TvDetailRBloc extends Bloc<TvDetailREvent, TvDetailRState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvRecommendations getTvRecommendations;

  TvDetailRBloc({
    required this.getTvRecommendations,
  }) : super(TvDetailREmpty()) {
    on<FetchTvR>((event, emit) async {
      emit(TvDetailRLoading());

      final recommendationResult = await getTvRecommendations.execute(event.id);

      recommendationResult.fold(
        (failure) {
          emit(TvDetailRError(failure.message));
        },
        (recommendation) {
          if (recommendation.isNotEmpty) {
            emit(TvDetailRLoaded(recommendation));
          } else {
            emit(TvDetailREmpty());
          }
        },
      );
    });
  }
}
