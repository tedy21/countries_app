import '../entities/country_summary.dart';
import '../entities/country_details.dart';

abstract class CountriesRepository {
  Future<List<CountrySummary>> getAllCountries();
  Future<List<CountrySummary>> searchCountriesByName(String name);
  Future<CountryDetails> getCountryDetails(String cca2);
}
