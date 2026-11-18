import 'map_local_cache.dart';
import 'map_remote_datasource.dart';
import 'models.dart';

class CampusMapRepository {
  final MapLocalCache _localCache = MapLocalCache();
  final MapRemoteDatasource _remoteDatasource = MapRemoteDatasource();

  Future<List<BlockPinModel>> getPins({required bool forceOffline}) async {
    if (!forceOffline) {
      try {
        final remotePins = await _remoteDatasource.fetchPins();
        await _localCache.cachePins(remotePins);
        return remotePins;
      } catch (_) {
        return await _localCache.getCachedPins(); // Fallback on network error
      }
    } else {
      return await _localCache.getCachedPins();
    }
  }

  Future<List<PinReportSummary>> getReports({required bool forceOffline}) async {
    if (!forceOffline) {
      try {
        final remoteReports = await _remoteDatasource.fetchReports();
        await _localCache.cacheReports(remoteReports);
        return remoteReports;
      } catch (_) {
        return await _localCache.getCachedReports(); // Fallback on network error
      }
    } else {
      return await _localCache.getCachedReports();
    }
  }
}
