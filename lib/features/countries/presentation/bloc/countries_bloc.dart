import 'package:flutter_bloc/flutter_bloc.dart';
import 'countries_event.dart';
import 'countries_state.dart';
import '../models/country_summary.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  List<CountrySummary> _allCountries = [];

  CountriesBloc() : super(CountriesInitial()) {
    on<LoadCountries>(_onLoadCountries);
    on<SearchCountries>(_onSearchCountries);
    on<RefreshCountries>(_onRefreshCountries);
  }

  Future<void> _onLoadCountries(
    LoadCountries event,
    Emitter<CountriesState> emit,
  ) async {
    emit(CountriesLoading());

    await Future.delayed(const Duration(seconds: 1));

    _allCountries = _getMockCountries();
    emit(CountriesLoaded(countries: _allCountries));
  }

  Future<void> _onSearchCountries(
    SearchCountries event,
    Emitter<CountriesState> emit,
  ) async {
    if (state is CountriesLoaded) {
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(CountriesLoaded(countries: _allCountries, searchQuery: ''));
        return;
      }

      final filtered = _allCountries
          .where((country) => country.name.toLowerCase().contains(query))
          .toList();

      emit(CountriesLoaded(
        countries: filtered,
        searchQuery: event.query,
      ));
    }
  }

  Future<void> _onRefreshCountries(
    RefreshCountries event,
    Emitter<CountriesState> emit,
  ) async {
    emit(CountriesLoading());

    await Future.delayed(const Duration(seconds: 1));

    _allCountries = _getMockCountries();
    emit(CountriesLoaded(countries: _allCountries));
  }

  List<CountrySummary> _getMockCountries() {
    return [
      const CountrySummary(
        name: 'Spain',
        flag: 'https://flagcdn.com/w320/es.png',
        population: 47351567,
        cca2: 'ES',
      ),
      const CountrySummary(
        name: 'United Kingdom',
        flag: 'https://flagcdn.com/w320/gb.png',
        population: 67281039,
        cca2: 'GB',
      ),
      const CountrySummary(
        name: 'Germany',
        flag: 'https://flagcdn.com/w320/de.png',
        population: 83240525,
        cca2: 'DE',
      ),
      const CountrySummary(
        name: 'Italy',
        flag: 'https://flagcdn.com/w320/it.png',
        population: 59554023,
        cca2: 'IT',
      ),
      const CountrySummary(
        name: 'France',
        flag: 'https://flagcdn.com/w320/fr.png',
        population: 67391582,
        cca2: 'FR',
      ),
      const CountrySummary(
        name: 'Canada',
        flag: 'https://flagcdn.com/w320/ca.png',
        population: 38005238,
        cca2: 'CA',
      ),
      const CountrySummary(
        name: 'United States',
        flag: 'https://flagcdn.com/w320/us.png',
        population: 331002651,
        cca2: 'US',
      ),
      const CountrySummary(
        name: 'Brazil',
        flag: 'https://flagcdn.com/w320/br.png',
        population: 212559417,
        cca2: 'BR',
      ),
      const CountrySummary(
        name: 'Japan',
        flag: 'https://flagcdn.com/w320/jp.png',
        population: 126476461,
        cca2: 'JP',
      ),
      const CountrySummary(
        name: 'India',
        flag: 'https://flagcdn.com/w320/in.png',
        population: 1380004385,
        cca2: 'IN',
      ),
      const CountrySummary(
        name: 'Portugal',
        flag: 'https://flagcdn.com/w320/pt.png',
        population: 10305564,
        cca2: 'PT',
      ),
      const CountrySummary(
        name: 'Netherlands',
        flag: 'https://flagcdn.com/w320/nl.png',
        population: 16655799,
        cca2: 'NL',
      ),
      const CountrySummary(
        name: 'Belgium',
        flag: 'https://flagcdn.com/w320/be.png',
        population: 11555997,
        cca2: 'BE',
      ),
      const CountrySummary(
        name: 'Australia',
        flag: 'https://flagcdn.com/w320/au.png',
        population: 25499884,
        cca2: 'AU',
      ),
      const CountrySummary(
        name: 'China',
        flag: 'https://flagcdn.com/w320/cn.png',
        population: 1439323776,
        cca2: 'CN',
      ),
      const CountrySummary(
        name: 'Russia',
        flag: 'https://flagcdn.com/w320/ru.png',
        population: 146599183,
        cca2: 'RU',
      ),
      const CountrySummary(
        name: 'Mexico',
        flag: 'https://flagcdn.com/w320/mx.png',
        population: 128932753,
        cca2: 'MX',
      ),
      const CountrySummary(
        name: 'South Korea',
        flag: 'https://flagcdn.com/w320/kr.png',
        population: 51780579,
        cca2: 'KR',
      ),
    ];
  }
}
