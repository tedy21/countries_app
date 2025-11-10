import 'package:equatable/equatable.dart';

class CountryDetails extends Equatable {
  final String name;
  final String flag;
  final int population;
  final String cca2;
  final List<String> capital;
  final String region;
  final String subregion;
  final double? area;
  final List<String> timezones;

  const CountryDetails({
    required this.name,
    required this.flag,
    required this.population,
    required this.cca2,
    required this.capital,
    required this.region,
    required this.subregion,
    this.area,
    required this.timezones,
  });

  @override
  List<Object?> get props => [
        name,
        flag,
        population,
        cca2,
        capital,
        region,
        subregion,
        area,
        timezones,
      ];
}
