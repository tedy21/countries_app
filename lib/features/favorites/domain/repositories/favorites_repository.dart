abstract class FavoritesRepository {
  Future<List<String>> getFavoriteCountryCodes();
  Future<void> addFavoriteCountryCode(String countryCode);
  Future<void> removeFavoriteCountryCode(String countryCode);
  Future<bool> isFavorite(String countryCode);
  Future<Map<String, bool>> getFavoriteStatusMap(List<String> countryCodes);
}
