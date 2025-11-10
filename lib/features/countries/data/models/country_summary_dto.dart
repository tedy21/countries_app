import 'package:equatable/equatable.dart';

class CountrySummaryDto extends Equatable {
  final NameDto name;
  final FlagsDto flags;
  final int population;
  final String cca2;

  const CountrySummaryDto({
    required this.name,
    required this.flags,
    required this.population,
    required this.cca2,
  });

  factory CountrySummaryDto.fromJson(Map<String, dynamic> json) {
    return CountrySummaryDto(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.toJson(),
      'flags': flags.toJson(),
      'population': population,
      'cca2': cca2,
    };
  }

  @override
  List<Object> get props => [name, flags, population, cca2];
}

class NameDto extends Equatable {
  final String common;

  const NameDto({required this.common});

  factory NameDto.fromJson(Map<String, dynamic> json) {
    return NameDto(
      common: json['common'] is String ? json['common'] as String : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'common': common,
    };
  }

  @override
  List<Object> get props => [common];
}

class FlagsDto extends Equatable {
  final String png;
  final String svg;

  const FlagsDto({
    required this.png,
    required this.svg,
  });

  factory FlagsDto.fromJson(Map<String, dynamic> json) {
    return FlagsDto(
      png: json['png'] is String ? json['png'] as String : '',
      svg: json['svg'] is String ? json['svg'] as String : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'png': png,
      'svg': svg,
    };
  }

  @override
  List<Object> get props => [png, svg];
}
