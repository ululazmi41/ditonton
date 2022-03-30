import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('state', () {
    testWidgets('Circular progress bar should display when movie is loading',
        (WidgetTester tester) async {
      // arrange
      when(mockNotifier.movieState).thenReturn(RequestState.Loading);

      // action
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      // assert
      expect(circular, findsOneWidget);
    });

    testWidgets("Should show error message when state is failed",
        (WidgetTester tester) async {
      // arrange
      when(mockNotifier.movieState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn("Error Testing");

      // act
      final errorType = find.byType(Text);
      final errorText = find.text("Error Testing");

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      // assert
      expect(errorType, findsOneWidget);
      expect(errorText, findsOneWidget);
    });
  });

  group('recommendation state', () {
    setUp(() {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.movieRecommendations).thenReturn([testMovie]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    });

    testWidgets(
        'Circular progress bar should display when recommendation state is loading',
        (WidgetTester tester) async {
      // arrange
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);

      // act
      final circular = find.byType(CircularProgressIndicator);
      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      // assert
      expect(circular, findsWidgets);
    });

    testWidgets(
        'Error message should display when recommendation state is Error',
        (WidgetTester tester) async {
      // arrange
      when(mockNotifier.recommendationState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn("Error testing");

      // act
      final errorType = find.byType(Text);
      final errorMessage = find.text("Error testing");

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      // assert
      expect(errorType, findsWidgets);
      expect(errorMessage, findsOneWidget);
    });

    testWidgets('Widgets should display when recommendation state is Loaded',
        (WidgetTester tester) async {
      // arrange
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);

      // act
      final cachedNetworkImage = find.byType(CachedNetworkImage);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      // assert
      expect(cachedNetworkImage, findsWidgets);
    });
  });

  group('Watchlist', () {
    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });
  });
}
