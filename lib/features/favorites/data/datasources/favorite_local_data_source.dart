abstract class FavoriteLocalDataSource {
  Future<List<String>> getFavoriteCountryCodes();
  Future<void> addFavoriteCountryCode(String countryCode);
  Future<void> removeFavoriteCountryCode(String countryCode);
  Future<bool> isFavorite(String countryCode);
}

