import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_on_the_air_tvs.dart';
import 'package:core/domain/usecases/get_popular_tvs.dart';
import 'package:core/domain/usecases/get_top_rated_tvs.dart';
import 'package:core/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvs, GetPopularTvs, GetTopRatedTvs])
void main() {
  late TvListBloc tvListBloc;
  late MockGetOnTheAirTvs mockGetOnTheAirTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetOnTheAirTvs = MockGetOnTheAirTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    tvListBloc = TvListBloc(
      getNowPlayingTvs: mockGetOnTheAirTvs,
      getPopularTvs: mockGetPopularTvs,
      getTopRatedTvs: mockGetTopRatedTvs,
    );
  });

  final tTv = Tv(
    firstAirDate: DateTime.parse("2000-01-01"),
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
    originCountry: const ["US"],
    originalLanguage: "EN",
    originalName: "Spider-Man",
  );
  final tTvList = <Tv>[tTv];

  group('on the air tvs', () {
    blocTest<TvListBloc, TvListState>(
      "now playing should be empty when usecase is called",
      build: () {
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => const Right([]));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FetchLoading(),
        FetchEmpty(),
      ],
      verify: (bloc) {
        verify(bloc.getNowPlayingTvs.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      "should Loading and return List<Tv> when usecase is called",
      build: () {
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FetchLoading(),
        FetchLoaded(tTvList),
      ],
      verify: (bloc) {
        verify(bloc.getNowPlayingTvs.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      "should return error when unsuccessful",
      build: () {
        when(mockGetOnTheAirTvs.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FetchLoading(),
        const FetchError("Server Failure"),
      ],
      verify: (bloc) {
        verify(bloc.getNowPlayingTvs.execute());
      },
    );
  });

  group('popular tvs', () {
    blocTest<TvListBloc, TvListState>(
      "should loading and return [] when usecase is called",
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => const Right([]));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FetchPopularLoading(),
        FetchPopularEmpty(),
      ],
      verify: (bloc) {
        verify(bloc.getPopularTvs.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      "should return List<Tv> when data request is successful",
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FetchPopularLoading(),
        FetchPopularLoaded(tTvList),
      ],
      verify: (bloc) {
        verify(bloc.getPopularTvs.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      "should return error when request is unsuccessful",
      build: () {
        when(mockGetPopularTvs.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FetchPopularLoading(),
        const FetchPopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(bloc.getPopularTvs.execute());
      },
    );
  });

  group('top rated tvs', () {
    blocTest<TvListBloc, TvListState>(
      'should loading, return [] when usecase is called',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => const Right([]));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FetchTopRatedLoading(),
        FetchTopRatedEmpty(),
      ],
      verify: (bloc) {
        verify(bloc.getTopRatedTvs.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      'should loading, return List<Tv> when usecase is called',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FetchTopRatedLoading(),
        FetchTopRatedLoaded(tTvList),
      ],
      verify: (bloc) {
        verify(bloc.getTopRatedTvs.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetTopRatedTvs.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FetchTopRatedLoading(),
        const FetchTopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(bloc.getTopRatedTvs.execute());
      },
    );
  });
}
