import 'package:equatable/equatable.dart';

abstract class CountryDetailEvent extends Equatable {
  const CountryDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadCountryDetail extends CountryDetailEvent {
  final String cca2;

  const LoadCountryDetail(this.cca2);

  @override
  List<Object> get props => [cca2];
}

class RefreshCountryDetail extends CountryDetailEvent {
  final String cca2;

  const RefreshCountryDetail(this.cca2);

  @override
  List<Object> get props => [cca2];
}
