import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    watchlistTvBloc = WatchlistTvBloc(
      getWatchlistTvs: mockGetWatchlistTvs,
    );
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    "should return [] when usecase is called",
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      FetchLoading(),
      FetchEmpty(),
    ],
    verify: (bloc) => {
      verify(bloc.getWatchlistTvs.execute()),
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    "should return List[Tv] when usecase is called",
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      FetchLoading(),
      FetchLoaded([testWatchlistTv]),
    ],
    verify: (bloc) => {
      verify(bloc.getWatchlistTvs.execute()),
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    "should return error when failure is thrown",
    build: () {
      when(mockGetWatchlistTvs.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure("Can't get data")));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      FetchLoading(),
      const FetchError("Can't get data"),
    ],
    verify: (bloc) => {
      verify(bloc.getWatchlistTvs.execute()),
    },
  );
}
