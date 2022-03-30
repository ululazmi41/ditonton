import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [
      GenreModel(id: 1, name: 'Action'),
    ],
    id: 1,
    imdbId: "test",
    homepage: "test",
    status: "finished",
    originalLanguage: "EN",
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 1,
    runtime: 120,
    tagline: "test",
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tJsonMovieDetailResponse = {
    "adult": false,
    "backdrop_path": 'backdropPath',
    "budget": 1,
    "genres": [
      {
        'id': 1,
        'name': 'Action',
      }
    ],
    "id": 1,
    "imdb_id": "test",
    "homepage": "test",
    "status": "finished",
    "original_language": "EN",
    "original_title": 'originalTitle',
    "overview": 'overview',
    "popularity": 1,
    "poster_path": 'posterPath',
    "release_date": 'releaseDate',
    "revenue": 1,
    "runtime": 120,
    "tagline": "test",
    "title": 'title',
    "video": false,
    "vote_average": 1,
    "vote_count": 1,
  };

  test('should be a subclass of MovieDetailResponse Json', () async {
    final result = tMovieDetailResponse.toJson();
    expect(result, tJsonMovieDetailResponse);
  });
}
