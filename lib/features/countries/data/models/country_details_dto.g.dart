// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountryDetailsDtoImpl _$$CountryDetailsDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CountryDetailsDtoImpl(
      name: NameDto.fromJson(json['name'] as Map<String, dynamic>),
      flags: FlagsDto.fromJson(json['flags'] as Map<String, dynamic>),
      population: (json['population'] as num).toInt(),
      cca2: json['cca2'] as String,
      capital: (json['capital'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      region: json['region'] as String? ?? '',
      subregion: json['subregion'] as String? ?? '',
      area: (json['area'] as num?)?.toDouble(),
      timezones: (json['timezones'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CountryDetailsDtoImplToJson(
        _$CountryDetailsDtoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'flags': instance.flags,
      'population': instance.population,
      'cca2': instance.cca2,
      'capital': instance.capital,
      'region': instance.region,
      'subregion': instance.subregion,
      'area': instance.area,
      'timezones': instance.timezones,
    };
