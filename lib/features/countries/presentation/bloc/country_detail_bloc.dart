import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/countries_repository.dart';
import 'country_detail_event.dart';
import 'country_detail_state.dart';

class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  final CountriesRepository repository;

  CountryDetailBloc({required this.repository})
      : super(CountryDetailInitial()) {
    on<LoadCountryDetail>(_onLoadCountryDetail);
    on<RefreshCountryDetail>(_onRefreshCountryDetail);
  }

  Future<void> _onLoadCountryDetail(
    LoadCountryDetail event,
    Emitter<CountryDetailState> emit,
  ) async {
    emit(CountryDetailLoading());

    try {
      final country = await repository.getCountryDetails(event.cca2);
      emit(CountryDetailLoaded(country: country));
    } on Failure catch (failure) {
      emit(CountryDetailError(failure.displayMessage));
    }
  }

  Future<void> _onRefreshCountryDetail(
    RefreshCountryDetail event,
    Emitter<CountryDetailState> emit,
  ) async {
    emit(CountryDetailLoading());

    try {
      final country = await repository.getCountryDetails(event.cca2);
      emit(CountryDetailLoaded(country: country));
    } on Failure catch (failure) {
      emit(CountryDetailError(failure.displayMessage));
    }
  }
}
