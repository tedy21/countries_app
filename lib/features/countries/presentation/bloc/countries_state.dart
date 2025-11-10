import 'package:equatable/equatable.dart';
import '../models/country_summary.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object> get props => [];
}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final List<CountrySummary> countries;
  final String searchQuery;

  const CountriesLoaded({
    required this.countries,
    this.searchQuery = '',
  });

  @override
  List<Object> get props => [countries, searchQuery];

  CountriesLoaded copyWith({
    List<CountrySummary>? countries,
    String? searchQuery,
  }) {
    return CountriesLoaded(
      countries: countries ?? this.countries,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class CountriesError extends CountriesState {
  final String message;

  const CountriesError(this.message);

  @override
  List<Object> get props => [message];
}
