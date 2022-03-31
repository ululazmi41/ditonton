import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tvs.dart';
import 'package:core/presentation/bloc/popular_tvs/popular_tvs_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late MockGetPopularTvs mockGetPopularTvs;
  late PopularTvsBloc popularTvsBloc;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvsBloc = PopularTvsBloc(mockGetPopularTvs);
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

  blocTest<PopularTvsBloc, PopularTvsState>(
    "should loading and return [] when usecase is called",
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    expect: () => [
      PopularTvsLoading(),
      PopularTvsEmpty(),
    ],
    verify: (bloc) => {
      verify(mockGetPopularTvs.execute()),
    },
  );

  blocTest<PopularTvsBloc, PopularTvsState>(
    "should loading and return List<Tv> when usecase is called",
    build: () {
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    expect: () => [
      PopularTvsLoading(),
      PopularTvsLoaded(tTvList),
    ],
    verify: (bloc) => {
      verify(mockGetPopularTvs.execute()),
    },
  );

  blocTest<PopularTvsBloc, PopularTvsState>(
    "should give error message when Failure is thrown",
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    expect: () => [
      PopularTvsLoading(),
      const PopularTvsError('Server Failure'),
    ],
  );
}
