import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_recommendation/movie_detail_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_watchlist/movie_detail_watchlist_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MovieDetailWatchlistBloc movieDetailWatchlistBloc;
  late MovieDetailRBloc movieDetailRBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
    movieDetailWatchlistBloc = MovieDetailWatchlistBloc(
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
    movieDetailRBloc = MovieDetailRBloc(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  const tId = 1;

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
  final tMovies = <Movie>[tMovie];

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should loading, load movie and recommendations when usecase is called",
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailLoaded(testMovieDetail, false, tMovies),
      ],
      verify: (bloc) {
        verify(bloc.getMovieDetail.execute(tId));
        verify(bloc.getMovieRecommendations.execute(tId));
        verify(bloc.getWatchListStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
        "should return error when request is unsuccessful",
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              MovieDetailLoading(),
              const MovieDetailError('Server Failure'),
            ],
        verify: (bloc) {
          verify(bloc.getMovieDetail.execute(tId));
          verify(bloc.getMovieRecommendations.execute(tId));
          verify(bloc.getWatchListStatus.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should return error when request on recommendation is unsuccessful",
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailErrorRecommendation(testMovieDetail, true, 'Server Failure'),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
      "should get the watchlist status",
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlist(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistLoaded(true),
      ],
      verify: (bloc) {
        verify(bloc.getWatchListStatus.execute(tId));
      },
    );

    blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
      "should execute save watchlist when function called",
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddingWatchlist(testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      },
      expect: () => [
        const AddingWatchlistSuccess('Added to Watchlist'),
        const WatchlistLoaded(true),
      ],
    );

    blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
      "should display error message when fails adding watchlist",
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddingWatchlist(testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      },
      expect: () => [
        // const AddingWatchlistSuccess('Failed'),
        const WatchlistLoaded(false),
      ],
    );

    blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
      "should remove watchlist when function called",
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure("Failed")));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemovingWatchlist(testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistLoaded(false),
        // const RemovingWatchlistSuccess('Failed'),
      ],
      verify: (bloc) {
        verify(bloc.removeWatchlist.execute(testMovieDetail));
        verify(bloc.getWatchListStatus.execute(tId));
      },
    );
  });

  group('Recommendation', () {
    blocTest<MovieDetailRBloc, MovieDetailRState>(
      "should return [] when request in successful",
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right([]));
        return movieDetailRBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieR(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieDetailRLoading(),
        MovieDetailREmpty(),
      ],
      verify: (bloc) {
        verify(bloc.getMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailRBloc, MovieDetailRState>(
      "should return data when request in successful",
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieDetailRBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieR(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieDetailRLoading(),
        MovieDetailRLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(bloc.getMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailRBloc, MovieDetailRState>(
      "should return error when request in unsuccessful",
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return movieDetailRBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieR(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieDetailRLoading(),
        MovieDetailRError('Failed'),
      ],
    );
  });
}
