// Mocks generated by Mockito 5.1.0 from annotations
// in tv/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i17;
import 'dart:typed_data' as _i18;

import 'package:core/core.dart' as _i7;
import 'package:core/utils/network_info.dart' as _i16;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i15;
import 'package:tv/data/datasources/db/tv_database_helper.dart' as _i14;
import 'package:tv/data/datasources/tv_local_data_source.dart' as _i12;
import 'package:tv/data/datasources/tv_remote_data_source.dart' as _i10;
import 'package:tv/data/models/tv_detail_model.dart' as _i3;
import 'package:tv/data/models/tv_model.dart' as _i11;
import 'package:tv/data/models/tv_table.dart' as _i13;
import 'package:tv/domain/entities/tv.dart' as _i8;
import 'package:tv/domain/entities/tv_detail.dart' as _i9;
import 'package:tv/domain/repositories/tv_repository.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeTvDetailResponse_1 extends _i1.Fake implements _i3.TvDetailResponse {
}

class _FakeResponse_2 extends _i1.Fake implements _i4.Response {}

class _FakeStreamedResponse_3 extends _i1.Fake implements _i4.StreamedResponse {
}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i5.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>> getOnTheAirTvs() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTvs, []),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.Tv>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>> getPopularTvs() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvs, []),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.Tv>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>> getTopRatedTvs() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvs, []),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.Tv>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.TvDetail>> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
              returnValue: Future<_i2.Either<_i7.Failure, _i9.TvDetail>>.value(
                  _FakeEither_0<_i7.Failure, _i9.TvDetail>()))
          as _i6.Future<_i2.Either<_i7.Failure, _i9.TvDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>> getTvRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.Tv>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>> searchTvs(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvs, [query]),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.Tv>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(_i9.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tv]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i9.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>> getWatchlistTvs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvs, []),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.Tv>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tv>>>);
}

/// A class which mocks [TvRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDataSource extends _i1.Mock
    implements _i10.TvRemoteDataSource {
  MockTvRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i11.TvModel>> getOnTheAirTvs() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTvs, []),
              returnValue: Future<List<_i11.TvModel>>.value(<_i11.TvModel>[]))
          as _i6.Future<List<_i11.TvModel>>);
  @override
  _i6.Future<List<_i11.TvModel>> getPopularTvs() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvs, []),
              returnValue: Future<List<_i11.TvModel>>.value(<_i11.TvModel>[]))
          as _i6.Future<List<_i11.TvModel>>);
  @override
  _i6.Future<List<_i11.TvModel>> getTopRatedTvs() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvs, []),
              returnValue: Future<List<_i11.TvModel>>.value(<_i11.TvModel>[]))
          as _i6.Future<List<_i11.TvModel>>);
  @override
  _i6.Future<_i3.TvDetailResponse> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
              returnValue:
                  Future<_i3.TvDetailResponse>.value(_FakeTvDetailResponse_1()))
          as _i6.Future<_i3.TvDetailResponse>);
  @override
  _i6.Future<List<_i11.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue: Future<List<_i11.TvModel>>.value(<_i11.TvModel>[]))
          as _i6.Future<List<_i11.TvModel>>);
  @override
  _i6.Future<List<_i11.TvModel>> searchTvs(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvs, [query]),
              returnValue: Future<List<_i11.TvModel>>.value(<_i11.TvModel>[]))
          as _i6.Future<List<_i11.TvModel>>);
}

/// A class which mocks [TvLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvLocalDataSource extends _i1.Mock implements _i12.TvLocalDataSource {
  MockTvLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertTvWatchlist(_i13.TvTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertTvWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<String> removeTvWatchlist(_i13.TvTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeTvWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i13.TvTable?> getTvById(int? id) => (super.noSuchMethod(
      Invocation.method(#getTvById, [id]),
      returnValue: Future<_i13.TvTable?>.value()) as _i6.Future<_i13.TvTable?>);
  @override
  _i6.Future<List<_i13.TvTable>> getWatchlistTvs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvs, []),
              returnValue: Future<List<_i13.TvTable>>.value(<_i13.TvTable>[]))
          as _i6.Future<List<_i13.TvTable>>);
  @override
  _i6.Future<void> cacheNowPlayingTvs(List<_i13.TvTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingTvs, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<List<_i13.TvTable>> getCachedNowPlayingTvs() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingTvs, []),
              returnValue: Future<List<_i13.TvTable>>.value(<_i13.TvTable>[]))
          as _i6.Future<List<_i13.TvTable>>);
}

/// A class which mocks [TvDatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDatabaseHelper extends _i1.Mock implements _i14.TvDatabaseHelper {
  MockTvDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i15.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i15.Database?>.value())
          as _i6.Future<_i15.Database?>);
  @override
  _i6.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<void> insertTvCacheTransaction(
          List<_i13.TvTable>? tvs, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertTvCacheTransaction, [tvs, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getCacheTvs(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheTvs, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<int> insertTvWatchlist(_i13.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertTvWatchlist, [tv]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeTvWatchlist(_i13.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeTvWatchlist, [tv]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getTvById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistTvs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvs, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i16.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i18.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i18.Uint8List>.value(_i18.Uint8List(0)))
          as _i6.Future<_i18.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3()))
          as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
