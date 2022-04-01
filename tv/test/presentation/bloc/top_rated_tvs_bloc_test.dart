import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:tv/presentation/bloc/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late TopRatedTvsBloc topRatedTvsBloc;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvsBloc = TopRatedTvsBloc(getTopRatedTvs: mockGetTopRatedTvs);
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

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
    "should loading and return [] when usecase is called",
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedTvsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvsLoading(),
      TopRatedTvsEmpty(),
    ],
    verify: (bloc) => [
      verify(bloc.getTopRatedTvs.execute()),
    ],
  );

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
    "should loading and return List<Tv> when usecase is called",
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return topRatedTvsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvsLoading(),
      TopRatedTvsLoaded(tTvList),
    ],
    verify: (bloc) => [
      verify(bloc.getTopRatedTvs.execute()),
    ],
  );

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
    "should return Error when Failure is thrown",
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvsLoading(),
      const TopRatedTvsError('Server Failure'),
    ],
    verify: (bloc) => [
      verify(bloc.getTopRatedTvs.execute()),
    ],
  );
}
