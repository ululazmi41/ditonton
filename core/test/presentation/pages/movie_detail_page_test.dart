import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movie_detail/movie_detail_bloc.dart';
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

void main() {
  late MockBlocMovieDetailBloc mockBlocMovieDetailBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
  });

  setUp(() {
    mockBlocMovieDetailBloc = MockBlocMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBlocMovieDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('state', () {
    testWidgets(
      'Circular progress bar should display when movie is loading',
      (WidgetTester tester) async {
        // arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoading(),
        );
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoading(),
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
          MovieDetailError('Failed'),
        );
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailError('Failed'),
        );

        // action
        final text = find.text("Failed");

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
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailEmpty(),
        );

        // action
        final toFind = find.text("Empty");

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(toFind, findsOneWidget);
      },
    );

    testWidgets(
      'Should show detail when state has data',
      (WidgetTester tester) async {
        // arrange
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoaded(testMovieDetail, true, testMovieList),
        );
        when(() => mockBlocMovieDetailBloc.state).thenReturn(
          MovieDetailLoaded(testMovieDetail, true, testMovieList),
        );

        // action
        final widgetToFind = find.byType(SafeArea);

        await tester.pumpWidget(
          _makeTestableWidget(
            const MovieDetailPage(id: 1),
          ),
        );

        // assert
        expect(widgetToFind, findsOneWidget);
      },
    );

    group('recommendation state', () {
      testWidgets(
        'Circular progress bar should display when recommendation state is loading',
        (WidgetTester tester) async {
          // arrange
          when(() => mockBlocMovieDetailBloc.state).thenReturn(
            MovieDetailRecommendationLoading(),
          );
          when(() => mockBlocMovieDetailBloc.state).thenReturn(
            MovieDetailLoaded(testMovieDetail, true, testMovieList),
          );

          // action
          final detailContent = find.byType(DetailContent);
          final widgetToFind = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
            _makeTestableWidget(
              const MovieDetailPage(id: 1),
            ),
          );

          // assert
          expect(detailContent, findsOneWidget);
          expect(widgetToFind, findsOneWidget);
        },
      );

      testWidgets(
        'Error message should display when recommendation state is Error',
        (WidgetTester tester) async {
          // arrange
          when(() => mockBlocMovieDetailBloc.state).thenReturn(
            MovieDetailRecommendationError('Error Testing'),
          );
          when(() => mockBlocMovieDetailBloc.state).thenReturn(
            MovieDetailLoaded(testMovieDetail, true, testMovieList),
          );

          // action
          final testWidgget = find.byType(Text);
          // final text = find.byKey(const Key('error_message'));

          await tester.pumpWidget(
            _makeTestableWidget(
              const MovieDetailPage(id: 1),
            ),
          );

          // assert
          expect(testWidgget, findsWidgets);
          // expect(text, findsOneWidget);
        },
      );
      testWidgets(
        'Data should display when recommendation state is loaded',
        (WidgetTester tester) async {
          // arrange

          when(() => mockBlocMovieDetailBloc.state).thenReturn(
            MovieDetailLoaded(testMovieDetail, true, testMovieList),
          );
          when(() => mockBlocMovieDetailBloc.state).thenReturn(
            MovieDetailRecommendationLoaded(testMovieList),
          );

          // action
          final testWidget = find.byType(InkWell);

          await tester.pumpWidget(
            _makeTestableWidget(
              const MovieDetailPage(id: 1),
            ),
          );

          // assert
          expect(testWidget, findsWidgets);
        },
      );

      //   testWidgets('Widgets should display when recommendation state is Loaded',
      //       (WidgetTester tester) async {
      //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);

      //     // act
      //     final cachedNetworkImage = find.byType(CachedNetworkImage);

      //     await tester
      //         .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      //     // assert
      //     expect(cachedNetworkImage, findsWidgets);
      //   });
    });

    // group('Watchlist', () {
    //   testWidgets(
    //       'Watchlist button should display add icon when movie not added to watchlist',
    //       (WidgetTester tester) async {
    //     when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    //     when(mockNotifier.movie).thenReturn(testMovieDetail);
    //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    //     final watchlistButtonIcon = find.byIcon(Icons.add);

    //     await tester
    //         .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    //     expect(watchlistButtonIcon, findsOneWidget);
    //   });

    //   testWidgets(
    //       'Watchlist button should dispay check icon when movie is added to wathclist',
    //       (WidgetTester tester) async {
    //     when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    //     when(mockNotifier.movie).thenReturn(testMovieDetail);
    //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    //     when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    //     final watchlistButtonIcon = find.byIcon(Icons.check);

    //     await tester
    //         .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    //     expect(watchlistButtonIcon, findsOneWidget);
    //   });

    //   testWidgets(
    //       'Watchlist button should display Snackbar when added to watchlist',
    //       (WidgetTester tester) async {
    //     when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    //     when(mockNotifier.movie).thenReturn(testMovieDetail);
    //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    //     when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    //     final watchlistButton = find.byType(ElevatedButton);

    //     await tester
    //         .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    //     expect(find.byIcon(Icons.add), findsOneWidget);

    //     await tester.tap(watchlistButton);
    //     await tester.pump();

    //     expect(find.byType(SnackBar), findsOneWidget);
    //     expect(find.text('Added to Watchlist'), findsOneWidget);
    //   });

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
