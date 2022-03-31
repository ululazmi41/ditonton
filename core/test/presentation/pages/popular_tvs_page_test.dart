import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/popular_tvs/popular_tvs_bloc.dart';
import 'package:core/presentation/pages/popular_tvs_page.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockBlocPopularTvsBloc extends MockBloc<PopularTvsEvent, PopularTvsState>
    implements PopularTvsBloc {}

class PopularTvsEventFake extends Fake implements PopularTvsEvent {}

class PopularTvsStateFake extends Fake implements PopularTvsState {}

void main() {
  late MockBlocPopularTvsBloc mockBlocPopularTvsBloc;

  setUp(() {
    mockBlocPopularTvsBloc = MockBlocPopularTvsBloc();
  });

  setUpAll(() {
    registerFallbackValue(PopularTvsEventFake);
    registerFallbackValue(PopularTvsStateFake);
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvsBloc>.value(
      value: mockBlocPopularTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBlocPopularTvsBloc.state).thenReturn(PopularTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBlocPopularTvsBloc.state)
        .thenReturn(PopularTvsLoaded(testTvList));

    final listViewFinder = find.byType(ListView);
    final tvCardFinder = find.byType(TvCard);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(listViewFinder, findsOneWidget);
    expect(tvCardFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBlocPopularTvsBloc.state)
        .thenReturn(PopularTvsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
