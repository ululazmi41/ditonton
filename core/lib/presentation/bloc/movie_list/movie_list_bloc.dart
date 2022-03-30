import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListEmpty()) {
    on<FetchNowPlayingMovies>(
      (event, emit) async {
        emit(FetchLoading());

        final result = await getNowPlayingMovies.execute();
        result.fold(
          (failure) {
            emit(FetchError(failure.message));
          },
          (movies) {
            if (movies.isEmpty) {
              emit(MovieListEmpty());
            } else {
              emit(FetchLoaded(movies));
            }
          },
        );
      },
    );

    on<FetchPopularMovies>((event, emit) async {
      emit(FetchPopularLoading());

      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(FetchPopularError(failure.message));
        },
        (movies) {
          emit(FetchPopularLoaded(movies));
        },
      );
    });

    on<FetchTopRatedMovies>((event, emit) async {
      emit(FetchTopRatedLoading());

      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(FetchTopRatedError(failure.message));
        },
        (movies) {
          emit(FetchTopRatedLoaded(movies));
        },
      );
    });
  }
}
