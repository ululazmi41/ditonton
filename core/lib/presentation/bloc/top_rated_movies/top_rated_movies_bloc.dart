import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies}) : super(FetchEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(FetchLoading());

      final result = await getTopRatedMovies.execute();

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
