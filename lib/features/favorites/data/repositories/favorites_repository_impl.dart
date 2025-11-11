import '../../../../core/errors/failures.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorite_local_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<List<String>> getFavoriteCountryCodes() async {
    try {
      return await localDataSource.getFavoriteCountryCodes();
    } catch (e) {
      throw CacheFailure('Failed to get favorite countries: $e');
    }
  }

  @override
  Future<void> addFavoriteCountryCode(String countryCode) async {
    try {
      await localDataSource.addFavoriteCountryCode(countryCode);
    } catch (e) {
      throw CacheFailure('Failed to add favorite country: $e');
    }
  }

  @override
  Future<void> removeFavoriteCountryCode(String countryCode) async {
    try {
      await localDataSource.removeFavoriteCountryCode(countryCode);
    } catch (e) {
      throw CacheFailure('Failed to remove favorite country: $e');
    }
  }

  @override
  Future<bool> isFavorite(String countryCode) async {
    try {
      return await localDataSource.isFavorite(countryCode);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<String, bool>> getFavoriteStatusMap(
      List<String> countryCodes) async {
    try {
      final favorites = await getFavoriteCountryCodes();
      final Map<String, bool> statusMap = {};
      for (final code in countryCodes) {
        statusMap[code] = favorites.contains(code);
      }
      return statusMap;
    } catch (e) {
      return {};
    }
  }
}
