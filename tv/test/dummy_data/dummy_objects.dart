import 'package:core/domain/entities/genre.dart';

import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testTvCache = TvTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  name: 'Spider-Man',
);

final testTvFromCache = Tv.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  name: 'Spider-Man',
);

final testTv = Tv(
  firstAirDate: DateTime.parse("2000-01-01"),
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  name: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
  originCountry: const ["US"],
  originalLanguage: "EN",
  originalName: "Spider-Man",
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
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
    Genre(id: 1, name: "test"),
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

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvTable = TvTable(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'title',
};
