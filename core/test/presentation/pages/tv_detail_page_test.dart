import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_detail_recommendation/tv_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/tv_detail_watchlist/tv_detail_watchlist_bloc.dart';
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

class MockBlocTvDetailRBloc extends MockBloc<TvDetailREvent, TvDetailRState>
    implements TvDetailRBloc {}

class TvDetailREventFake extends Fake implements TvDetailREvent {}

class TvDetailRStateFake extends Fake implements TvDetailRState {}

class MockBlocTvDetailWatchlistBloc
    extends MockBloc<TvDetailWatchlistEvent, TvDetailWatchlistState>
    implements TvDetailWatchlistBloc {}

class TvDetailWatchlistEventFake extends Fake
    implements TvDetailWatchlistEvent {}

class TvDetailWatchlistStateFake extends Fake
    implements TvDetailWatchlistState {}

void main() {
  late MockBlocTvDetailBloc mockBlocTvDetailBloc;
  late MockBlocTvDetailRBloc mockBlocTvDetailRBloc;
  late MockBlocTvDetailWatchlistBloc mockBlocTvDetailWatchlistBloc;

  setUp(() {
    mockBlocTvDetailBloc = MockBlocTvDetailBloc();
    mockBlocTvDetailRBloc = MockBlocTvDetailRBloc();
    mockBlocTvDetailWatchlistBloc = MockBlocTvDetailWatchlistBloc();
  });

  setUpAll(() {
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvDetailStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockBlocTvDetailBloc,
      child: BlocProvider<TvDetailRBloc>.value(
        value: mockBlocTvDetailRBloc,
        child: BlocProvider<TvDetailWatchlistBloc>.value(
          value: mockBlocTvDetailWatchlistBloc,
          child: MaterialApp(
            home: body,
          ),
        ),
      ),
    );
  }

  group('state', () {
    testWidgets(
      'Circular progress bar should display when tv and recommendation is loading',
      (WidgetTester tester) async {
        // arrange
        when(() => mockBlocTvDetailBloc.state).thenReturn(
          TvDetailLoading(),
        );
        when(() => mockBlocTvDetailRBloc.state).thenReturn(
          TvDetailRLoading(),
        );
        when(() => mockBlocTvDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final circular = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(
          _makeTestableWidget(
            const TvDetailPage(id: 1),
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
        when(() => mockBlocTvDetailBloc.state).thenReturn(
          TvDetailError('Tv Detail Failed'),
        );
        when(() => mockBlocTvDetailRBloc.state).thenReturn(
          TvDetailRLoading(),
        );
        when(() => mockBlocTvDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final text = find.text("Tv Detail Failed");

        await tester.pumpWidget(
          _makeTestableWidget(
            const TvDetailPage(id: 1),
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
        when(() => mockBlocTvDetailBloc.state).thenReturn(
          TvDetailEmpty(),
        );
        when(() => mockBlocTvDetailRBloc.state).thenReturn(
          TvDetailRLoading(),
        );
        when(() => mockBlocTvDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final text = find.text("Empty");

        await tester.pumpWidget(
          _makeTestableWidget(
            const TvDetailPage(id: 1),
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
        when(() => mockBlocTvDetailBloc.state).thenReturn(
          TvDetailLoaded(testTvDetail, true, testTvList),
        );
        when(() => mockBlocTvDetailRBloc.state).thenReturn(
          TvDetailRLoading(),
        );
        when(() => mockBlocTvDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final widgetToFind = find.byType(DetailContent);

        await tester.pumpWidget(
          _makeTestableWidget(
            const TvDetailPage(id: 1),
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
        when(() => mockBlocTvDetailBloc.state).thenReturn(
          TvDetailLoaded(testTvDetail, true, testTvList),
        );
        when(() => mockBlocTvDetailRBloc.state).thenReturn(
          TvDetailRLoading(),
        );
        when(() => mockBlocTvDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // action
        final circular = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(
          _makeTestableWidget(
            const TvDetailPage(id: 1),
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
        when(() => mockBlocTvDetailBloc.state).thenReturn(
          TvDetailLoaded(testTvDetail, true, testTvList),
        );
        when(() => mockBlocTvDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // Arrange
        when(() => mockBlocTvDetailRBloc.state).thenReturn(
          TvDetailRError('Tv Detail Failure'),
        );

        // action
        final errroText = find.text('Tv Detail Failure');

        await tester.pumpWidget(
          _makeTestableWidget(
            const TvDetailPage(id: 1),
          ),
        );

        // assert
        expect(errroText, findsOneWidget);
      },
    );

    testWidgets(
      'No data should display when recommendation state is loaded',
      (WidgetTester tester) async {
        // pre-arrange
        when(() => mockBlocTvDetailBloc.state).thenReturn(
          TvDetailLoaded(testTvDetail, true, testTvList),
        );
        when(() => mockBlocTvDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // Arrange
        when(() => mockBlocTvDetailRBloc.state).thenReturn(
          TvDetailREmpty(),
        );

        // action
        final textEmpty = find.text('Empty');

        await tester.pumpWidget(
          _makeTestableWidget(
            const TvDetailPage(id: 1),
          ),
        );

        // assert
        expect(textEmpty, findsWidgets);
      },
    );

    testWidgets(
      'Data should display when recommendation state is loaded',
      (WidgetTester tester) async {
        // pre-arrange
        when(() => mockBlocTvDetailBloc.state).thenReturn(
          TvDetailLoaded(testTvDetail, true, testTvList),
        );
        when(() => mockBlocTvDetailWatchlistBloc.state).thenReturn(
          WatchlistLoaded(true),
        );

        // Arrange
        when(() => mockBlocTvDetailRBloc.state).thenReturn(
          TvDetailRLoaded(testTvList),
        );

        // pre-action
        final detailContent = find.byType(DetailContent);

        // action
        final inkWell = find.byType(InkWell);

        await tester.pumpWidget(
          _makeTestableWidget(
            const TvDetailPage(id: 1),
          ),
        );

        // pre-assert
        expect(detailContent, findsOneWidget);

        // assert
        expect(inkWell, findsWidgets);
      },
    );
  });
}
