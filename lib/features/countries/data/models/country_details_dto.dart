import 'package:freezed_annotation/freezed_annotation.dart';
import 'country_summary_dto.dart';

part 'country_details_dto.freezed.dart';
part 'country_details_dto.g.dart';

@freezed
class CountryDetailsDto with _$CountryDetailsDto {
  const factory CountryDetailsDto({
    required NameDto name,
    required FlagsDto flags,
    required int population,
    required String cca2,
    @Default([]) List<String> capital,
    @Default('') String region,
    @Default('') String subregion,
    double? area,
    @Default([]) List<String> timezones,
  }) = _CountryDetailsDto;

  factory CountryDetailsDto.fromJson(Map<String, dynamic> json) {
    try {
      return _$CountryDetailsDtoFromJson(json);
    } catch (e) {
      return CountryDetailsDto(
        name: NameDto.fromJson(
          json['name'] is Map<String, dynamic>
              ? json['name'] as Map<String, dynamic>
              : <String, dynamic>{},
        ),
        flags: FlagsDto.fromJson(
          json['flags'] is Map<String, dynamic>
              ? json['flags'] as Map<String, dynamic>
              : <String, dynamic>{},
        ),
        population: json['population'] is int
            ? json['population'] as int
            : (json['population'] as num?)?.toInt() ?? 0,
        cca2: json['cca2'] is String ? json['cca2'] as String : '',
        capital: json['capital'] is List
            ? (json['capital'] as List<dynamic>).whereType<String>().toList()
            : [],
        region: json['region'] is String ? json['region'] as String : '',
        subregion:
            json['subregion'] is String ? json['subregion'] as String : '',
        area: json['area'] is num
            ? (json['area'] as num).toDouble()
            : json['area'] as double?,
        timezones: json['timezones'] is List
            ? (json['timezones'] as List<dynamic>).whereType<String>().toList()
            : [],
      );
    }
  }
}
