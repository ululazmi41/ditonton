import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie_detail_recommendation/movie_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/movie_detail_watchlist/movie_detail_watchlist_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockBlocMovieDetailBloc
    extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockBlocMovieDetailRBloc
    extends MockBloc<MovieDetailREvent, MovieDetailRState>
    implements MovieDetailRBloc {}

class MovieDetailREventFake extends Fake implements MovieDetailREvent {}

class MovieDetailRStateFake extends Fake implements MovieDetailRState {}

class MockBlocMovieDetailWatchlistBloc
    extends MockBloc<MovieDetailWatchlistEvent, MovieDetailWatchlistState>
    implements MovieDetailWatchlistBloc {}

class MovieDetailWatchlistEventFake extends Fake
    implements MovieDetailWatchlistEvent {}

class MovieDetailWatchlistStateFake extends Fake
    implements MovieDetailWatchlistState {}

void main() {
  late MockBlocMovieDetailBloc mockBlocMovieDetailBloc;
  late MockBlocMovieDetailRBloc mockBlocMovieDetailRBloc;
  late MockBlocMovieDetailWatchlistBloc mockBlocMovieDetailWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieDetailREventFake());
    registerFallbackValue(MovieDetailRStateFake());
    registerFallbackValue(MovieDetailWatchlistEventFake());
    registerFallbackValue(MovieDetailWatchlistStateFake());
  });

  setUp(() {
    mockBlocMovieDetailBloc = MockBlocMovieDetailBloc();
    mockBlocMovieDetailRBloc = MockBlocMovieDetailRBloc();
    mockBlocMovieDetailWatchlistBloc = MockBlocMovieDetailWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBlocMovieDetailBloc,
      child: BlocProvider<MovieDetailRBloc>.value(
        value: mockBlocMovieDetailRBloc,
        child: BlocProvider<MovieDetailWatchlistBloc>.value(
          value: mockBlocMovieDetailWatchlistBloc,
          child: MaterialApp(
            home: body,
          ),
        ),
      ),
    );
  }

  group('state', () {
    testWidgets(
      'Circular progress bar should display when movie and recommendation is loading',
      (WidgetTester tester) async {
        // arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoading(),
        );
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailRLoading(),
        );
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final circular = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(circular, findsOneWidget);
      },
    );

    testWidgets(
      'Should show error message when state is failed',
      (WidgetTester tester) async {
        // arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailError('Movie Detail Failed'),
        );
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailRLoading(),
        );
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final text = find.text("Movie Detail Failed");

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(text, findsOneWidget);
      },
    );

    testWidgets(
      'Should show empty when state is no data',
      (WidgetTester tester) async {
        // arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailEmpty(),
        );
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailRLoading(),
        );
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final text = find.text("Empty");

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(text, findsOneWidget);
      },
    );

    testWidgets(
      'Should show detail when state has data',
      (WidgetTester tester) async {
        // arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoaded(testMovieDetail, true, testMovieList),
        );
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailRLoading(),
        );
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final widgetToFind = find.byType(DetailContent);

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(widgetToFind, findsOneWidget);
      },
    );
  });

  group('recommendation state', () {
    testWidgets(
      'Circular progress bar should display when recommendation state is loading',
      (WidgetTester tester) async {
        // arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoaded(testMovieDetail, true, testMovieList),
        );
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailRLoading(),
        );
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final circular = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(circular, findsWidgets);
      },
    );

    testWidgets(
      'Error message should display when recommendation state is Error',
      (WidgetTester tester) async {
        // pre-arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoaded(testMovieDetail, true, testMovieList),
        );
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // Arrange
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailRError('Movie Detail Failure'),
        );

        // action
        final errroText = find.text('Movie Detail Failure');

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(errroText, findsWidgets);
      },
    );

    testWidgets(
      'No data should display when recommendation state is loaded',
      (WidgetTester tester) async {
        // pre-arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoaded(testMovieDetail, true, testMovieList),
        );
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // Arrange
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailREmpty(),
        );

        // pre-action
        final detailContent = find.byType(DetailContent);

        // action
        final textEmpty = find.text('Empty');

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // pre-assert
        expect(detailContent, findsOneWidget);

        // assert
        expect(textEmpty, findsOneWidget);
      },
    );

    testWidgets(
      'Data should display when recommendation state is loaded',
      (WidgetTester tester) async {
        // pre-arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoaded(testMovieDetail, true, testMovieList),
        );
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // Arrange
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailRLoaded(testMovieList),
        );

        // pre-action
        final detailContent = find.byType(DetailContent);

        // action
        final inkWell = find.byType(InkWell);

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // pre-assert
        expect(detailContent, findsOneWidget);

        // assert
        expect(inkWell, findsWidgets);
      },
    );
  });

  group('Watchlist', () {
    testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
        // pre-arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoaded(testMovieDetail, true, testMovieList),
        );
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailRLoaded(testMovieList),
        );

        // Arrange
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(false),
        );

        // action
        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(watchlistButtonIcon, findsOneWidget);
      },
    );

    testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
        // pre-arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoaded(testMovieDetail, true, testMovieList),
        );
        when(() => mockBlocMovieDetailRBloc.state).thenReturn(
          MovieDetailRLoaded(testMovieList),
        );

        // Arrange
        when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(watchlistButtonIcon, findsOneWidget);
      },
    );

    // testWidgets(
    //   'Watchlist button should display Snackbar when added to watchlist',
    //   (WidgetTester tester) async {
    //     // pre-arrange
    //     when(() => mockBlocMovieDetailBloc.state).thenReturn(
    //       MovieDetailLoaded(testMovieDetail, true, testMovieList),
    //     );
    //     when(() => mockBlocMovieDetailRBloc.state).thenReturn(
    //       MovieDetailRLoaded(testMovieList),
    //     );

    //     // Arrange
    //     when(() => mockBlocMovieDetailWatchlistBloc.state).thenReturn(
    //       AddingWatchlistSuccess('Added to Watchlist'),
    //     );

    //     // action
    //     await tester.pumpWidget(
    //       _makeTestableWidget(
    //         const MovieDetailPage(id: 1),
    //       ),
    //     );

    //     // assert
    //     expect(find.byType(SnackBar), findsOneWidget);
    //     expect(find.text('Added to Watchlist'), findsOneWidget);
    //   },
    // );

    //   testWidgets(
    //       'Watchlist button should display AlertDialog when add to watchlist failed',
    //       (WidgetTester tester) async {
    //     when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    //     when(mockNotifier.movie).thenReturn(testMovieDetail);
    //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    //     when(mockNotifier.watchlistMessage).thenReturn('Failed');

    //     final watchlistButton = find.byType(ElevatedButton);

    //     await tester
    //         .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    //     expect(find.byIcon(Icons.add), findsOneWidget);

    //     await tester.tap(watchlistButton);
    //     await tester.pump();

    //     expect(find.byType(AlertDialog), findsOneWidget);
    //     expect(find.text('Failed'), findsOneWidget);
    //   });
  });
}
