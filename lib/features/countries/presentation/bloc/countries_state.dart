import 'package:equatable/equatable.dart';
import '../../domain/entities/country_summary.dart';
import '../models/sort_type.dart';

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
  final SortType sortType;

  const CountriesLoaded({
    required this.countries,
    this.searchQuery = '',
    this.sortType = SortType.nameAscending,
  });

  @override
  List<Object> get props => [countries, searchQuery, sortType];

  CountriesLoaded copyWith({
    List<CountrySummary>? countries,
    String? searchQuery,
    SortType? sortType,
  }) {
    return CountriesLoaded(
      countries: countries ?? this.countries,
      searchQuery: searchQuery ?? this.searchQuery,
      sortType: sortType ?? this.sortType,
    );
  }
}

class CountriesError extends CountriesState {
  final String message;

  const CountriesError(this.message);

  @override
  List<Object> get props => [message];
}
