import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc =
        TopRatedMoviesBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    "should loading and return [] when usecase is called",
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      FetchLoading(),
      FetchEmpty(),
    ],
    verify: (bloc) => [
      verify(bloc.getTopRatedMovies.execute()),
    ],
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    "should loading and return List<Movie> when usecase is called",
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      FetchLoading(),
      FetchLoaded(tMovieList),
    ],
    verify: (bloc) => [
      verify(bloc.getTopRatedMovies.execute()),
    ],
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    "should return Error when Failure is thrown",
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      FetchLoading(),
      const FetchError('Server Failure'),
    ],
    verify: (bloc) => [
      verify(bloc.getTopRatedMovies.execute()),
    ],
  );
}
