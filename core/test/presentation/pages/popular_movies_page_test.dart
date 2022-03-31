import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockBlocPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class PopularMoviesEventfake extends Fake implements PopularMoviesEvent {}

class PopularMoviesStateFake extends Fake implements PopularMoviesState {}

void main() {
  late MockBlocPopularMoviesBloc mockBlocPopularMoviesBloc;

  setUp(() {
    mockBlocPopularMoviesBloc = MockBlocPopularMoviesBloc();
  });

  setUpAll(() {
    registerFallbackValue(PopularMoviesEventfake());
    registerFallbackValue(PopularMoviesStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockBlocPopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBlocPopularMoviesBloc.state)
        .thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView and MovieCard when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBlocPopularMoviesBloc.state)
        .thenReturn(PopularMoviesLoaded(<Movie>[testMovie]));

    final listViewFinder = find.byType(ListView);
    final movieCardFinder = find.byType(MovieCard);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
    expect(movieCardFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBlocPopularMoviesBloc.state)
        .thenReturn(PopularMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
