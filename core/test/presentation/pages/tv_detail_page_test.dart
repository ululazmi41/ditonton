import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockBlocTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class TvDetailStateFake extends Fake implements TvDetailState {}

void main() {
  late MockBlocTvDetailBloc mockBlocTvDetailBloc;

  setUp(() {
    mockBlocTvDetailBloc = MockBlocTvDetailBloc();
  });

  setUpAll(() {
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvDetailStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockBlocTvDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('state', () {
    testWidgets('Circular progress bar should display when tv is loading',
        (WidgetTester tester) async {
      // arrange
      when(() => mockBlocTvDetailBloc.state).thenReturn(TvDetailLoading());

      // action
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      // assert
      expect(circular, findsOneWidget);
    });

    testWidgets('should display data when tv is loaded',
        (WidgetTester tester) async {
      // arrange
      when(() => mockBlocTvDetailBloc.state)
          .thenReturn(TvDetailLoaded(testTvDetail, true, testTvList));

      // action
      final detailContent = find.byType(DetailContent);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      // assert
      expect(detailContent, findsOneWidget);
    });

    testWidgets("Should show error message when state is failed",
        (WidgetTester tester) async {
      // arrange
      when(() => mockBlocTvDetailBloc.state)
          .thenReturn(TvDetailError('Error Testing'));

      // act
      final errorType = find.byType(Text);
      final errorText = find.text("Error Testing");

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      // assert
      expect(errorType, findsOneWidget);
      expect(errorText, findsOneWidget);
    });
  });

  // group('recommendation state', () {
  //   setUp(() {
  //     when(mockNotifier.tvState).thenReturn(RequestState.loaded);
  //     when(mockNotifier.tv).thenReturn(testTvDetail);
  //     when(mockNotifier.tvRecommendations).thenReturn([testTv]);
  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   });

  //   testWidgets(
  //       'Circular progress bar should display when recommendation state is loading',
  //       (WidgetTester tester) async {
  //     // arrange
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.loading);

  //     // act
  //     final circular = find.byType(CircularProgressIndicator);
  //     await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

  //     // assert
  //     expect(circular, findsWidgets);
  //   });

  //   testWidgets(
  //       'Error message should display when recommendation state is Error',
  //       (WidgetTester tester) async {
  //     // arrange
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.error);
  //     when(mockNotifier.message).thenReturn("Error testing");

  //     // act
  //     final errorType = find.byType(Text);
  //     final errorMessage = find.text("Error testing");

  //     await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

  //     // assert
  //     expect(errorType, findsWidgets);
  //     expect(errorMessage, findsOneWidget);
  //   });

  //   testWidgets('Widgets should display when recommendation state is Loaded',
  //       (WidgetTester tester) async {
  //     // arrange
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);

  //     // act
  //     final cachedNetworkImage = find.byType(CachedNetworkImage);

  //     await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

  //     // assert
  //     expect(cachedNetworkImage, findsWidgets);
  //   });
  // });

  // testWidgets(
  //     'Watchlist button should display add icon when tv not added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.tvState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);

  //   final watchlistButtonIcon = find.byIcon(Icons.add);

  //   await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

  //   expect(watchlistButtonIcon, findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should dispay check icon when tv is added to wathclist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.tvState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(true);

  //   final watchlistButtonIcon = find.byIcon(Icons.check);

  //   await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

  //   expect(watchlistButtonIcon, findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.tvState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.tvState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Failed');

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
