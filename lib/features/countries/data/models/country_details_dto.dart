import 'package:equatable/equatable.dart';
import 'country_summary_dto.dart';

class CountryDetailsDto extends Equatable {
  final NameDto name;
  final FlagsDto flags;
  final int population;
  final String cca2;
  final List<String> capital;
  final String region;
  final String subregion;
  final double? area;
  final List<String> timezones;

  const CountryDetailsDto({
    required this.name,
    required this.flags,
    required this.population,
    required this.cca2,
    required this.capital,
    required this.region,
    required this.subregion,
    this.area,
    required this.timezones,
  });

  factory CountryDetailsDto.fromJson(Map<String, dynamic> json) {
    return CountryDetailsDto(
      name: NameDto.fromJson(json['name'] is Map<String, dynamic>
          ? json['name'] as Map<String, dynamic>
          : <String, dynamic>{}),
      flags: FlagsDto.fromJson(json['flags'] is Map<String, dynamic>
          ? json['flags'] as Map<String, dynamic>
          : <String, dynamic>{}),
      population: json['population'] is int
          ? json['population'] as int
          : (json['population'] as num?)?.toInt() ?? 0,
      cca2: json['cca2'] is String ? json['cca2'] as String : '',
      capital: json['capital'] is List
          ? (json['capital'] as List<dynamic>).whereType<String>().toList()
          : [],
      region: json['region'] is String ? json['region'] as String : '',
      subregion: json['subregion'] is String ? json['subregion'] as String : '',
      area: json['area'] is num
          ? (json['area'] as num).toDouble()
          : json['area'] as double?,
      timezones: json['timezones'] is List
          ? (json['timezones'] as List<dynamic>).whereType<String>().toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.toJson(),
      'flags': flags.toJson(),
      'population': population,
      'cca2': cca2,
      'capital': capital,
      'region': region,
      'subregion': subregion,
      'area': area,
      'timezones': timezones,
    };
  }

  @override
  List<Object?> get props => [
        name,
        flags,
        population,
        cca2,
        capital,
        region,
        subregion,
        area,
        timezones,
      ];
}
