import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air TV Series', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_on_the_air.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTvs();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Series', () {
    final tTvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json')))
            .tvList;

    test('should return list of tv series when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_popular.json'), 200));
      // act
      final result = await dataSource.getPopularTvs();
      // assert
      expect(result, tTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Series', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvs();
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series detail', () {
    const tId = 2;
    // final tTvDetail = TvDetailResponse.fromJson(
    //     json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return tv series detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, isA<TvDetailResponse>());
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series recommendations', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    const tId = 2;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv series', () {
    final tSearchResult =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv_search.json')))
            .tvList;
    const tQuery = 'Demon Slayer';

    test('should return list of tv series when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_search.json'), 200));
      // act
      final result = await dataSource.searchTvs(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvs(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}