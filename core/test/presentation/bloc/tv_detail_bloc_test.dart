import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/remove_tv_watchlist.dart';
import 'package:core/domain/usecases/save_tv_watchlist.dart';
import 'package:core/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListTvStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListTvStatus mockGetWatchlistTvStatus;
  late MockSaveTvWatchlist mockSaveWatchlist;
  late MockRemoveTvWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistTvStatus = MockGetWatchListTvStatus();
    mockSaveWatchlist = MockSaveTvWatchlist();
    mockRemoveWatchlist = MockRemoveTvWatchlist();
    tvDetailBloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchlistTvStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

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
  final tTvs = <Tv>[tTv];

  group('Detail', () {
    blocTest<TvDetailBloc, TvDetailState>(
      "should Loading and return data and recommendations when usecase is called",
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvDetailLoading(),
        TvDetailLoaded(testTvDetail, true, tTvs),
      ],
      verify: (bloc) {
        verify(bloc.getTvDetail.execute(tId));
        verify(bloc.getTvRecommendations.execute(tId));
        verify(bloc.getWatchListStatus.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      "should return error on detail when Failure is thrown",
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvDetailLoading(),
        const TvDetailError('Failed'),
      ],
      verify: (bloc) {
        verify(bloc.getTvDetail.execute(tId));
        verify(bloc.getTvRecommendations.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      "should return error on recommendations when request is unsuccessful on recommendations",
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvDetailLoading(),
        TvDetailErrorRecommendation(testTvDetail, false, 'Failed'),
      ],
      verify: (bloc) {
        verify(bloc.getTvDetail.execute(tId));
        verify(bloc.getTvRecommendations.execute(tId));
        verify(bloc.getWatchListStatus.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      "should get the watchlist status",
      build: () {
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const IsAddedToWatchlist(true),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should save watchlist when usecase is called',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testTvDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistMessage('Success'),
        const IsAddedToWatchlist(true),
      ],
      verify: (bloc) {
        verify(bloc.saveWatchlist.execute(testTvDetail));
        verify(bloc.getWatchListStatus.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testTvDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistMessage('Removed'),
        const IsAddedToWatchlist(false),
      ],
      verify: (bloc) {
        verify(bloc.removeWatchlist.execute(testTvDetail));
        verify(bloc.getWatchListStatus.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should execute remove watchlist when usecase is called',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testTvDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistMessage('Added to Watchlist'),
        const IsAddedToWatchlist(true),
      ],
      verify: (bloc) {
        verify(bloc.getWatchListStatus.execute(testTvDetail.id));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should return error when removing watchlist was unsuccesful',
      build: () {
        when(mockRemoveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testTvDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistMessage('Failed'),
        const IsAddedToWatchlist(false),
      ],
      verify: (bloc) {
        verify(bloc.removeWatchlist.execute(testTvDetail));
      },
    );
  });

  group('recommendations', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should return empty data when request is successful',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right([]));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendations(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvDetailRecommendationLoading(),
        TvDetailRecommendationLoaded([]),
      ],
      verify: (bloc) {
        verify(bloc.getTvRecommendations.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should return data when request is successful',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvList));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendations(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvDetailRecommendationLoading(),
        TvDetailRecommendationLoaded(testTvList),
      ],
      verify: (bloc) {
        verify(bloc.getTvRecommendations.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should return error when request is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendations(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvDetailRecommendationLoading(),
        const TvDetailRecommendationError('Failed'),
      ],
      verify: (bloc) {
        verify(bloc.getTvRecommendations.execute(tId));
      },
    );
  });
}
