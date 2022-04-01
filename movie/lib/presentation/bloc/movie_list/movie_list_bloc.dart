import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
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
        emit(MovieListLoading());

        final result = await getNowPlayingMovies.execute();
        result.fold(
          (failure) {
            emit(MovieListError(failure.message));
          },
          (movies) {
            if (movies.isEmpty) {
              emit(MovieListEmpty());
            } else {
              emit(MovieListLoaded(movies));
            }
          },
        );
      },
    );
  }
}
