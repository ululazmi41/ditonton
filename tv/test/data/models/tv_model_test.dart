import 'package:tv/data/models/tv_model.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "test",
    firstAirDate: DateTime.parse("2000-01-01"),
    genreIds: const [1],
    id: 1,
    name: "1",
    originCountry: const ["US"],
    originalLanguage: "EN",
    originalName: "test",
    overview: "test",
    popularity: 1.1,
    posterPath: "test",
    voteAverage: 5,
    voteCount: 5,
  );

  final tTv = Tv(
    backdropPath: "test",
    firstAirDate: DateTime.parse("2000-01-01"),
    genreIds: const [1],
    id: 1,
    name: "1",
    originCountry: const ["US"],
    originalLanguage: "EN",
    originalName: "test",
    overview: "test",
    popularity: 1.1,
    posterPath: "test",
    voteAverage: 5,
    voteCount: 5,
  );

  final tJsonTv = {
    "backdrop_path": "test",
    "first_air_date": "2000-01-01",
    "genre_ids": [1],
    "id": 1,
    "name": "1",
    "origin_country": ["US"],
    "original_language": "EN",
    "original_name": "test",
    "overview": "test",
    "popularity": 1.1,
    "poster_path": "test",
    "vote_average": 5.0,
    "vote_count": 5,
  };

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });

  test('should be a subclass of Tv Json', () async {
    final result = tTvModel.toJson();
    expect(result, tJsonTv);
  });
}
