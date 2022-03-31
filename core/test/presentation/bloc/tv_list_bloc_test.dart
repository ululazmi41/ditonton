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
        TvListLoading(),
        TvListEmpty(),
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
        TvListLoading(),
        TvListLoaded(tTvList),
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
        TvListLoading(),
        TvListError("Server Failure"),
      ],
      verify: (bloc) {
        verify(bloc.getNowPlayingTvs.execute());
      },
    );
  });
}
