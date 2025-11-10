import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/countries_repository.dart';
import '../../domain/entities/country_summary.dart';
import '../../domain/entities/country_details.dart';
import '../datasources/countries_remote_data_source.dart';
import '../models/country_summary_dto.dart';
import '../models/country_details_dto.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource remoteDataSource;

  CountriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CountrySummary>> getAllCountries() async {
    try {
      final dtos = await remoteDataSource.getAllCountries();
      return dtos.map((dto) => _mapSummaryDtoToEntity(dto)).toList();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Unknown error: $e');
    }
  }

  @override
  Future<List<CountrySummary>> searchCountriesByName(String name) async {
    try {
      final dtos = await remoteDataSource.searchCountriesByName(name);
      return dtos.map((dto) => _mapSummaryDtoToEntity(dto)).toList();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Unknown error: $e');
    }
  }

  @override
  Future<CountryDetails> getCountryDetails(String cca2) async {
    try {
      final dto = await remoteDataSource.getCountryDetails(cca2);
      return _mapDetailsDtoToEntity(dto);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Unknown error: $e');
    }
  }

  CountrySummary _mapSummaryDtoToEntity(CountrySummaryDto dto) {
    return CountrySummary(
      name: dto.name.common,
      flag: dto.flags.png,
      population: dto.population,
      cca2: dto.cca2,
    );
  }

  CountryDetails _mapDetailsDtoToEntity(CountryDetailsDto dto) {
    return CountryDetails(
      name: dto.name.common,
      flag: dto.flags.png,
      population: dto.population,
      cca2: dto.cca2,
      capital: dto.capital,
      region: dto.region,
      subregion: dto.subregion,
      area: dto.area,
      timezones: dto.timezones,
    );
  }
}
