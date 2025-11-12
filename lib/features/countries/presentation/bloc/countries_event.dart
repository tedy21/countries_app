import 'package:equatable/equatable.dart';
import '../models/sort_type.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

class LoadCountries extends CountriesEvent {
  const LoadCountries();
}

class SearchCountries extends CountriesEvent {
  final String query;

  const SearchCountries(this.query);

  @override
  List<Object> get props => [query];
}

class RefreshCountries extends CountriesEvent {
  const RefreshCountries();
}

class ToggleFavorite extends CountriesEvent {
  final String cca2;

  const ToggleFavorite(this.cca2);

  @override
  List<Object> get props => [cca2];
}

class SortCountries extends CountriesEvent {
  final SortType sortType;

  const SortCountries(this.sortType);

  @override
  List<Object> get props => [sortType];
}
