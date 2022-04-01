import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_recommendation_event.dart';
part 'movie_detail_recommendation_state.dart';

class MovieDetailRBloc extends Bloc<MovieDetailREvent, MovieDetailRState> {
  var watchlistMessage = '';
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailRBloc({
    required this.getMovieRecommendations,
  }) : super(MovieDetailREmpty()) {
    on<FetchMovieR>((event, emit) async {
      emit(MovieDetailRLoading());

      final recommendationResult =
          await getMovieRecommendations.execute(event.id);

      recommendationResult.fold(
        (failure) {
          emit(MovieDetailRError(failure.message));
        },
        (recommendation) {
          if (recommendation.isNotEmpty) {
            emit(MovieDetailRLoaded(recommendation));
          } else {
            emit(MovieDetailREmpty());
          }
        },
      );
    });
  }
}
