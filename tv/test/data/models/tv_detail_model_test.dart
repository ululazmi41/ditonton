import 'package:core/data/models/genre_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvDetailResponse = TvDetailResponse(
    spokenLanguages: [
      SpokenLanguage(englishName: "test", iso6391: "test", name: "test"),
    ],
    networks: [
      Network(
          name: "name",
          id: 1,
          logoPath: "logoPath",
          originCountry: "originCountry"),
    ],
    productionCountries: [
      ProductionCountry(iso31661: "test", name: "test"),
    ],
    lastEpisodeToAir: LastEpisodeToAir(
      airDate: DateTime.parse("2000-01-01"),
      episodeNumber: 1,
      id: 1,
      name: "name",
      overview: "overview",
      productionCode: "productionCode",
      seasonNumber: 1,
      stillPath: "stillPath",
      voteAverage: 4.4,
      voteCount: 1,
    ),
    seasons: [
      Season(
        airDate: DateTime.parse("2000-01-01"),
        episodeCount: 1,
        id: 1,
        name: "name",
        overview: "overview",
        posterPath: "posterPath",
        seasonNumber: 4,
      ),
    ],
    name: 'title',
    adult: false,
    backdropPath: "test",
    createdBy: const [
      {
        "id": 1238142,
        "creditId": "5d29d20ebe4b36756aa15541",
        "name": "Julio Jiménez",
        "gender": 2,
        "profilePath": null
      }
    ],
    episodeRunTime: const [1],
    firstAirDate: DateTime.parse("2000-01-01"),
    genres: const [
      GenreModel(id: 1, name: "test"),
    ],
    homepage: "test",
    id: 1,
    inProduction: true,
    languages: const ["EN"],
    lastAirDate: DateTime.parse("2000-01-02"),
    nextEpisodeToAir: const {
      "air_date": "2022-03-23",
      "episode_number": 27,
      "id": 3602819,
      "name": "",
      "overview": "",
      "production_code": "",
      "season_number": 2,
      "still_path": null,
      "vote_average": 0,
      "vote_count": 0
    },
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    posterPath: 'posterPath',
    overview: 'overview',
    originCountry: const ["US"],
    originalLanguage: "EN",
    originalName: "Test",
    popularity: 1.1,
    productionCompanies: const [],
    status: "finished",
    tagline: "test",
    type: "Scripted",
    voteAverage: 1.1,
    voteCount: 1,
  );

  final tJsonTvDetailResponse = {
    'last_episode_to_air': {
      'air_date': '2000-01-01',
      'episode_number': 1,
      'id': 1,
      'name': 'name',
      'overview': 'overview',
      'production_code': 'productionCode',
      'season_number': 1,
      'still_path': 'stillPath',
      'vote_average': 4.4,
      'vote_count': 1
    },
    'seasons': [
      {
        'air_date': '2000-01-01',
        'episode_count': 1,
        'id': 1,
        'name': 'name',
        'overview': 'overview',
        'poster_path': 'posterPath',
        'season_number': 4
      }
    ],
    'name': 'title',
    'adult': false,
    'backdrop_path': 'test',
    'created_by': [
      {
        'id': 1238142,
        'creditId': '5d29d20ebe4b36756aa15541',
        'name': 'Julio Jiménez',
        'gender': 2,
        'profilePath': null
      }
    ],
    'episode_run_time': [1],
    'first_air_date': '2000-01-01',
    'genres': [
      {
        'id': 1,
        'name': 'test',
      }
    ],
    'homepage': 'test',
    'id': 1,
    'in_production': true,
    'languages': ['EN'],
    'last_air_date': '2000-01-02',
    'next_episode_to_air': {
      'air_date': '2022-03-23',
      'episode_number': 27,
      'id': 3602819,
      'name': '',
      'overview': '',
      'production_code': '',
      'season_number': 2,
      'still_path': null,
      'vote_average': 0,
      'vote_count': 0
    },
    'networks': [
      {
        'name': 'name',
        'id': 1,
        'logo_path': 'logoPath',
        'origin_country': 'originCountry'
      }
    ],
    'number_of_episodes': 1,
    'number_of_seasons': 1,
    'poster_path': 'posterPath',
    'overview': 'overview',
    'origin_country': ['US'],
    'original_language': 'EN',
    "original_name": "Test",
    "popularity": 1.1,
    'production_countries': [
      {
        "iso_3166_1": "test",
        "name": "test",
      }
    ],
    "production_companies": [],
    "status": "finished",
    'spoken_languages': [
      {
        'english_name': 'test',
        'iso_639_1': 'test',
        'name': 'test',
      },
    ],
    "tagline": "test",
    "type": "Scripted",
    "vote_average": 1.1,
    "vote_count": 1,
  };

  test('should be a subclass of TvDetailResponse Json', () async {
    final result = tTvDetailResponse.toJson();
    expect(result, tJsonTvDetailResponse);
  });
}
