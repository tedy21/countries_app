import 'package:equatable/equatable.dart';

class CountrySummary extends Equatable {
  final String name;
  final String flag;
  final int population;
  final String cca2;
  final bool isFavorite;

  const CountrySummary({
    required this.name,
    required this.flag,
    required this.population,
    required this.cca2,
    this.isFavorite = false,
  });

  @override
  List<Object> get props => [name, flag, population, cca2, isFavorite];

  CountrySummary copyWith({
    String? name,
    String? flag,
    int? population,
    String? cca2,
    bool? isFavorite,
  }) {
    return CountrySummary(
      name: name ?? this.name,
      flag: flag ?? this.flag,
      population: population ?? this.population,
      cca2: cca2 ?? this.cca2,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
