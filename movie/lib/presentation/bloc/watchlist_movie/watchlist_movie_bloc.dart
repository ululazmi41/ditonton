import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({required this.getWatchlistMovies}) : super(FetchEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(FetchLoading());

      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(FetchError(failure.message));
        },
        (movies) {
          if (movies.isNotEmpty) {
            emit(FetchLoaded(movies));
          } else {
            emit(FetchEmpty());
          }
        },
      );
    });
  }
}
