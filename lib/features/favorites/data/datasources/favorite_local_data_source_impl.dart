import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_local_data_source.dart';

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  static const String _favoritesKey = 'favorite_country_codes';

  @override
  Future<List<String>> getFavoriteCountryCodes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList(_favoritesKey);
      return favoritesJson ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addFavoriteCountryCode(String countryCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavoriteCountryCodes();
      if (!favorites.contains(countryCode)) {
        favorites.add(countryCode);
        await prefs.setStringList(_favoritesKey, favorites);
      }
    } catch (e) {
      // TODO: Handle error - log or throw exception
    }
  }

  @override
  Future<void> removeFavoriteCountryCode(String countryCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavoriteCountryCodes();
      favorites.remove(countryCode);
      await prefs.setStringList(_favoritesKey, favorites);
    } catch (e) {
      // TODO: Handle error - log or throw exception
    }
  }

  @override
  Future<bool> isFavorite(String countryCode) async {
    try {
      final favorites = await getFavoriteCountryCodes();
      return favorites.contains(countryCode);
    } catch (e) {
      return false;
    }
  }
}
