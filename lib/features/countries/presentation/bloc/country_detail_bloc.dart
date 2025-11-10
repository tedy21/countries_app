import 'package:flutter_bloc/flutter_bloc.dart';
import 'country_detail_event.dart';
import 'country_detail_state.dart';
import '../models/country_details.dart';

class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  CountryDetailBloc() : super(CountryDetailInitial()) {
    on<LoadCountryDetail>(_onLoadCountryDetail);
    on<RefreshCountryDetail>(_onRefreshCountryDetail);
  }

  Future<void> _onLoadCountryDetail(
    LoadCountryDetail event,
    Emitter<CountryDetailState> emit,
  ) async {
    emit(CountryDetailLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    final country = _getMockCountryDetail(event.cca2);
    if (country != null) {
      emit(CountryDetailLoaded(country: country));
    } else {
      emit(const CountryDetailError('Country not found'));
    }
  }

  Future<void> _onRefreshCountryDetail(
    RefreshCountryDetail event,
    Emitter<CountryDetailState> emit,
  ) async {
    emit(CountryDetailLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    final country = _getMockCountryDetail(event.cca2);
    if (country != null) {
      emit(CountryDetailLoaded(country: country));
    } else {
      emit(const CountryDetailError('Country not found'));
    }
  }

  CountryDetails? _getMockCountryDetail(String cca2) {
    final mockData = {
      'IT': const CountryDetails(
        name: 'Italy',
        flag: 'https://flagcdn.com/w320/it.png',
        population: 60360000,
        cca2: 'IT',
        capital: ['Rome'],
        region: 'Europe',
        subregion: 'Southern Europe',
        area: 301340.0,
        timezones: ['UTC+01:00', 'UTC+02:00'],
      ),
      'ES': const CountryDetails(
        name: 'Spain',
        flag: 'https://flagcdn.com/w320/es.png',
        population: 47351567,
        cca2: 'ES',
        capital: ['Madrid'],
        region: 'Europe',
        subregion: 'Southern Europe',
        area: 505992.0,
        timezones: ['UTC', 'UTC+01:00'],
      ),
      'GB': const CountryDetails(
        name: 'United Kingdom',
        flag: 'https://flagcdn.com/w320/gb.png',
        population: 67281039,
        cca2: 'GB',
        capital: ['London'],
        region: 'Europe',
        subregion: 'Northern Europe',
        area: 242900.0,
        timezones: [
          'UTC-08:00',
          'UTC-05:00',
          'UTC-04:00',
          'UTC-03:00',
          'UTC-02:00',
          'UTC',
          'UTC+01:00',
          'UTC+02:00',
          'UTC+06:00'
        ],
      ),
      'DE': const CountryDetails(
        name: 'Germany',
        flag: 'https://flagcdn.com/w320/de.png',
        population: 83240525,
        cca2: 'DE',
        capital: ['Berlin'],
        region: 'Europe',
        subregion: 'Western Europe',
        area: 357114.0,
        timezones: ['UTC+01:00'],
      ),
      'FR': const CountryDetails(
        name: 'France',
        flag: 'https://flagcdn.com/w320/fr.png',
        population: 67391582,
        cca2: 'FR',
        capital: ['Paris'],
        region: 'Europe',
        subregion: 'Western Europe',
        area: 551695.0,
        timezones: [
          'UTC-10:00',
          'UTC-09:30',
          'UTC-09:00',
          'UTC-08:00',
          'UTC-04:00',
          'UTC-03:00',
          'UTC+01:00',
          'UTC+03:00',
          'UTC+04:00',
          'UTC+05:00',
          'UTC+10:00',
          'UTC+11:00',
          'UTC+12:00'
        ],
      ),
      'US': const CountryDetails(
        name: 'United States',
        flag: 'https://flagcdn.com/w320/us.png',
        population: 331002651,
        cca2: 'US',
        capital: ['Washington, D.C.'],
        region: 'Americas',
        subregion: 'North America',
        area: 9372610.0,
        timezones: [
          'UTC-12:00',
          'UTC-11:00',
          'UTC-10:00',
          'UTC-09:00',
          'UTC-08:00',
          'UTC-07:00',
          'UTC-06:00',
          'UTC-05:00',
          'UTC-04:00',
          'UTC+10:00',
          'UTC+12:00'
        ],
      ),
      'CA': const CountryDetails(
        name: 'Canada',
        flag: 'https://flagcdn.com/w320/ca.png',
        population: 38005238,
        cca2: 'CA',
        capital: ['Ottawa'],
        region: 'Americas',
        subregion: 'North America',
        area: 9984670.0,
        timezones: [
          'UTC-08:00',
          'UTC-07:00',
          'UTC-06:00',
          'UTC-05:00',
          'UTC-04:00',
          'UTC-03:30',
          'UTC-03:00',
          'UTC+00:00'
        ],
      ),
      'BR': const CountryDetails(
        name: 'Brazil',
        flag: 'https://flagcdn.com/w320/br.png',
        population: 212559417,
        cca2: 'BR',
        capital: ['Brasília'],
        region: 'Americas',
        subregion: 'South America',
        area: 8515767.0,
        timezones: ['UTC-05:00', 'UTC-04:00', 'UTC-03:00', 'UTC-02:00'],
      ),
      'JP': const CountryDetails(
        name: 'Japan',
        flag: 'https://flagcdn.com/w320/jp.png',
        population: 126476461,
        cca2: 'JP',
        capital: ['Tokyo'],
        region: 'Asia',
        subregion: 'Eastern Asia',
        area: 377930.0,
        timezones: ['UTC+09:00'],
      ),
      'IN': const CountryDetails(
        name: 'India',
        flag: 'https://flagcdn.com/w320/in.png',
        population: 1380004385,
        cca2: 'IN',
        capital: ['New Delhi'],
        region: 'Asia',
        subregion: 'Southern Asia',
        area: 3287590.0,
        timezones: ['UTC+05:30'],
      ),
    };

    return mockData[cca2];
  }
}
