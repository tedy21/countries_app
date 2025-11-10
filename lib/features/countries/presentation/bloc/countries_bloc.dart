import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/countries_repository.dart';
import '../../../favorites/domain/repositories/favorites_repository.dart';
import '../../domain/entities/country_summary.dart';
import 'countries_event.dart';
import 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountriesRepository repository;
  final FavoritesRepository favoritesRepository;
  List<CountrySummary> _allCountries = [];

  CountriesBloc({
    required this.repository,
    required this.favoritesRepository,
  }) : super(CountriesInitial()) {
    on<LoadCountries>(_onLoadCountries);
    on<SearchCountries>(_onSearchCountries);
    on<RefreshCountries>(_onRefreshCountries);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadCountries(
    LoadCountries event,
    Emitter<CountriesState> emit,
  ) async {
    emit(CountriesLoading());

    try {
      final countries = await repository.getAllCountries();
      final favoriteStatusMap = await _getFavoriteStatusMap(countries);
      _allCountries =
          _updateCountriesWithFavorites(countries, favoriteStatusMap);
      emit(CountriesLoaded(countries: _allCountries));
    } on Failure catch (failure) {
      emit(CountriesError(failure.message));
    }
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

    try {
      final countries = await repository.getAllCountries();
      final favoriteStatusMap = await _getFavoriteStatusMap(countries);
      _allCountries =
          _updateCountriesWithFavorites(countries, favoriteStatusMap);
      emit(CountriesLoaded(countries: _allCountries));
    } on Failure catch (failure) {
      emit(CountriesError(failure.message));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<CountriesState> emit,
  ) async {
    if (state is CountriesLoaded) {
      final currentState = state as CountriesLoaded;
      final country = _allCountries.firstWhere(
        (c) => c.cca2 == event.cca2,
        orElse: () => currentState.countries.firstWhere(
          (c) => c.cca2 == event.cca2,
        ),
      );

      final isCurrentlyFavorite = country.isFavorite;

      try {
        if (isCurrentlyFavorite) {
          await favoritesRepository.removeFavoriteCountryCode(event.cca2);
        } else {
          await favoritesRepository.addFavoriteCountryCode(event.cca2);
        }

        final updatedCountry = country.copyWith(
          isFavorite: !isCurrentlyFavorite,
        );

        _allCountries = _allCountries.map((c) {
          return c.cca2 == event.cca2 ? updatedCountry : c;
        }).toList();

        final updatedCountries = currentState.countries.map((c) {
          return c.cca2 == event.cca2 ? updatedCountry : c;
        }).toList();

        emit(CountriesLoaded(
          countries: updatedCountries,
          searchQuery: currentState.searchQuery,
        ));
      } catch (e) {
        // TODO: Handle error - show snackbar or toast
        // For now, silently fail to maintain UX
      }
    }
  }

  Future<Map<String, bool>> _getFavoriteStatusMap(
      List<CountrySummary> countries) async {
    try {
      final countryCodes = countries.map((c) => c.cca2).toList();
      return await favoritesRepository.getFavoriteStatusMap(countryCodes);
    } catch (e) {
      return {};
    }
  }

  List<CountrySummary> _updateCountriesWithFavorites(
    List<CountrySummary> countries,
    Map<String, bool> favoriteStatusMap,
  ) {
    return countries.map((country) {
      final isFavorite = favoriteStatusMap[country.cca2] ?? false;
      return country.copyWith(isFavorite: isFavorite);
    }).toList();
  }
}
