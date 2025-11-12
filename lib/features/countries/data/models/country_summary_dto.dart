import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_summary_dto.freezed.dart';
part 'country_summary_dto.g.dart';

@freezed
class CountrySummaryDto with _$CountrySummaryDto {
  const factory CountrySummaryDto({
    required NameDto name,
    required FlagsDto flags,
    required int population,
    required String cca2,
  }) = _CountrySummaryDto;

  factory CountrySummaryDto.fromJson(Map<String, dynamic> json) {
    try {
      return _$CountrySummaryDtoFromJson(json);
    } catch (e) {
      return CountrySummaryDto(
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
      );
    }
  }
}

@freezed
class NameDto with _$NameDto {
  const factory NameDto({
    required String common,
  }) = _NameDto;

  factory NameDto.fromJson(Map<String, dynamic> json) {
    try {
      return _$NameDtoFromJson(json);
    } catch (e) {
      return NameDto(
        common: json['common'] is String ? json['common'] as String : '',
      );
    }
  }
}

@freezed
class FlagsDto with _$FlagsDto {
  const factory FlagsDto({
    required String png,
    required String svg,
  }) = _FlagsDto;

  factory FlagsDto.fromJson(Map<String, dynamic> json) {
    try {
      return _$FlagsDtoFromJson(json);
    } catch (e) {
      return FlagsDto(
        png: json['png'] is String ? json['png'] as String : '',
        svg: json['svg'] is String ? json['svg'] as String : '',
      );
    }
  }
}
