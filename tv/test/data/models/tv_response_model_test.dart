import 'dart:convert';

import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
    firstAirDate: DateTime.parse("2003-10-21"),
    genreIds: const [18],
    id: 11250,
    name: "Pasión de gavilanes",
    originCountry: const ["CO"],
    originalLanguage: "es",
    originalName: "Pasión de gavilanes",
    overview:
        "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
    popularity: 3359.477,
    posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
    voteAverage: 7.7,
    voteCount: 1747,
  );
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
            "first_air_date": "2003-10-21",
            "genre_ids": [18],
            "id": 11250,
            "name": "Pasión de gavilanes",
            "origin_country": ["CO"],
            "original_language": "es",
            "original_name": "Pasión de gavilanes",
            "overview":
                "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
            "popularity": 3359.477,
            "poster_path": "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
            "vote_average": 7.7,
            "vote_count": 1747
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
