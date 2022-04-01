import 'package:core/core.dart';

import '../models/tv_table.dart';
import 'db/tv_database_helper.dart';

abstract class TvLocalDataSource {
  Future<String> insertTvWatchlist(TvTable movie);
  Future<String> removeTvWatchlist(TvTable movie);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTvs();
  Future<void> cacheNowPlayingTvs(List<TvTable> movies);
  Future<List<TvTable>> getCachedNowPlayingTvs();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final TvDatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheNowPlayingTvs(List<TvTable> tvs) async {
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertTvCacheTransaction(tvs, 'now playing');
  }

  @override
  Future<List<TvTable>> getCachedNowPlayingTvs() async {
    final result = await databaseHelper.getCacheTvs('now playing');
    if (result.isNotEmpty) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<String> insertTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertTvWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.removeTvWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvs() async {
    final result = await databaseHelper.getWatchlistTvs();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
