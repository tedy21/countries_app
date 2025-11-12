// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountrySummaryDtoImpl _$$CountrySummaryDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CountrySummaryDtoImpl(
      name: NameDto.fromJson(json['name'] as Map<String, dynamic>),
      flags: FlagsDto.fromJson(json['flags'] as Map<String, dynamic>),
      population: (json['population'] as num).toInt(),
      cca2: json['cca2'] as String,
    );

Map<String, dynamic> _$$CountrySummaryDtoImplToJson(
        _$CountrySummaryDtoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'flags': instance.flags,
      'population': instance.population,
      'cca2': instance.cca2,
    };

_$NameDtoImpl _$$NameDtoImplFromJson(Map<String, dynamic> json) =>
    _$NameDtoImpl(
      common: json['common'] as String,
    );

Map<String, dynamic> _$$NameDtoImplToJson(_$NameDtoImpl instance) =>
    <String, dynamic>{
      'common': instance.common,
    };

_$FlagsDtoImpl _$$FlagsDtoImplFromJson(Map<String, dynamic> json) =>
    _$FlagsDtoImpl(
      png: json['png'] as String,
      svg: json['svg'] as String,
    );

Map<String, dynamic> _$$FlagsDtoImplToJson(_$FlagsDtoImpl instance) =>
    <String, dynamic>{
      'png': instance.png,
      'svg': instance.svg,
    };
