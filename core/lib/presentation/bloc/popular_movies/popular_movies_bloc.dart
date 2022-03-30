import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(FetchEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(FetchLoading());

      final result = await getPopularMovies.execute();

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
