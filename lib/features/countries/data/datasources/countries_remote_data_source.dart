import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/country_summary_dto.dart';
import '../models/country_details_dto.dart';

abstract class CountriesRemoteDataSource {
  Future<List<CountrySummaryDto>> getAllCountries();
  Future<List<CountrySummaryDto>> searchCountriesByName(String name);
  Future<CountryDetailsDto> getCountryDetails(String cca2);
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  final DioClient dioClient;

  CountriesRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<CountrySummaryDto>> getAllCountries() async {
    try {
      final response = await dioClient.get(
        'all',
        queryParameters: {
          'fields': 'name,flags,population,cca2',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 304) {
        dynamic responseData = response.data;

        if (responseData == null) {
          throw ServerException('No data received from server');
        }

        if (responseData is List) {
          final data = responseData;
          return data
              .whereType<Map<String, dynamic>>()
              .map((json) => CountrySummaryDto.fromJson(json))
              .toList();
        } else if (responseData is Map) {
          final data = Map<String, dynamic>.from(responseData);
          return [CountrySummaryDto.fromJson(data)];
        } else {
          throw ServerException('Invalid response format');
        }
      } else {
        throw ServerException(
          'Failed to load countries',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.badResponse) {
        throw ServerException('Server error: ${e.response?.statusCode}');
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Unknown error: $e');
    }
  }

  @override
  Future<List<CountrySummaryDto>> searchCountriesByName(String name) async {
    try {
      final response = await dioClient.get(
        'name/$name',
        queryParameters: {
          'fields': 'name,flags,population,cca2',
        },
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          final List<dynamic> data = response.data as List<dynamic>;
          return data
              .whereType<Map<String, dynamic>>()
              .map((json) => CountrySummaryDto.fromJson(json))
              .toList();
        } else if (response.data is Map) {
          final Map<String, dynamic> data =
              response.data as Map<String, dynamic>;
          return [CountrySummaryDto.fromJson(data)];
        } else {
          throw ServerException('Invalid response format');
        }
      } else {
        throw ServerException('Failed to search countries');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.badResponse) {
        throw ServerException('Server error: ${e.response?.statusCode}');
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Unknown error: $e');
    }
  }

  @override
  Future<CountryDetailsDto> getCountryDetails(String cca2) async {
    try {
      final response = await dioClient.get(
        'alpha/$cca2',
        queryParameters: {
          'fields':
              'name,flags,population,cca2,capital,region,subregion,area,timezones',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 304) {
        dynamic responseData = response.data;

        if (responseData == null) {
          throw ServerException('No data received from server');
        }

        if (responseData is List) {
          final data = responseData;
          final firstItem = data.isNotEmpty ? data[0] : null;
          if (firstItem is Map) {
            return CountryDetailsDto.fromJson(
              Map<String, dynamic>.from(firstItem),
            );
          } else {
            throw ServerException('Country not found');
          }
        } else if (responseData is Map) {
          final data = Map<String, dynamic>.from(responseData);
          return CountryDetailsDto.fromJson(data);
        } else {
          throw ServerException('Invalid response format');
        }
      } else {
        throw ServerException(
          'Failed to load country details',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.badResponse) {
        throw ServerException('Server error: ${e.response?.statusCode}');
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Unknown error: $e');
    }
  }
}
