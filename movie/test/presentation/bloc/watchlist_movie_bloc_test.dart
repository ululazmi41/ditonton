import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return [] when usecase is called',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      FetchLoading(),
      FetchEmpty(),
    ],
    verify: (bloc) {
      verify(bloc.getWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return List[Movie] when usecase is called',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      FetchLoading(),
      FetchLoaded([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(bloc.getWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return error when failure is',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure("Can't get data")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      FetchLoading(),
      const FetchError("Can't get data"),
    ],
    verify: (bloc) {
      verify(bloc.getWatchlistMovies.execute());
    },
  );
}
