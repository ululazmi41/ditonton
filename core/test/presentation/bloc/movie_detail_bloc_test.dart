import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
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

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should get data from the usecase",
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      wait: const Duration(milliseconds: 500),
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should loading, load movie and recommendations when usecase is called",
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailLoaded(testMovieDetail),
        MovieDetailRecommendationLoaded(tMovies),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should update error message when request in successful",
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailLoaded(testMovieDetail),
        const MovieDetailRecommendationError("Failed"),
      ],
    );

    group('Watchlist', () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        "should get the watchlist status",
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          const IsAddedToWatchlist(true),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        "should execute save watchlist when function called",
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Success'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        "should execute remove watchlist when function called",
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Removed'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        "should update watchlist status when add watchlist success",
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        },
        expect: () => [
          const AddWatchlistMessage('Added to Watchlist'),
          const IsAddedToWatchlist(true),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        "should update watchlist message when add watchlist failed",
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        },
        expect: () => [
          const AddWatchlistMessage('Failed'),
          const IsAddedToWatchlist(false),
        ],
      );
    });

    group('on Error', () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        "should return error when removing data from watchlist is unsuccesful",
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (realInvocation) async => const Left(DatabaseFailure("Failed")));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        },
        expect: () => [
          const AddWatchlistMessage('Failed'),
          const IsAddedToWatchlist(false),
        ],
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        "should return error when data is unsuccessful",
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MovieDetailLoading(),
          const MovieDetailError('Server Failure'),
        ],
      );
    });
  });
}
