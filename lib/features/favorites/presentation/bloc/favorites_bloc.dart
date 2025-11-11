import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../../countries/domain/repositories/countries_repository.dart';
import '../../../countries/domain/entities/country_details.dart';
import '../../domain/repositories/favorites_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository favoritesRepository;
  final CountriesRepository countriesRepository;

  FavoritesBloc({
    required this.favoritesRepository,
    required this.countriesRepository,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<RefreshFavorites>(_onRefreshFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());

    try {
      final favoriteCodes = await favoritesRepository.getFavoriteCountryCodes();

      if (favoriteCodes.isEmpty) {
        emit(const FavoritesLoaded(favorites: []));
        return;
      }

      final List<CountryDetails> favorites = [];
      for (final code in favoriteCodes) {
        try {
          final country = await countriesRepository.getCountryDetails(code);
          favorites.add(country);
        } catch (e) {
          // TODO: Handle individual country fetch errors
          // Skip countries that fail to load
        }
      }

      emit(FavoritesLoaded(favorites: favorites));
    } on Failure catch (failure) {
      emit(FavoritesError(failure.message));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites: $e'));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;

      try {
        await favoritesRepository.removeFavoriteCountryCode(event.cca2);

        final updatedFavorites = currentState.favorites
            .where((country) => country.cca2 != event.cca2)
            .toList();

        emit(FavoritesLoaded(favorites: updatedFavorites));
      } catch (e) {
        // TODO: Handle error - show snackbar or toast
        // For now, silently fail to maintain UX
      }
    }
  }

  Future<void> _onRefreshFavorites(
    RefreshFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());

    try {
      final favoriteCodes = await favoritesRepository.getFavoriteCountryCodes();

      if (favoriteCodes.isEmpty) {
        emit(const FavoritesLoaded(favorites: []));
        return;
      }

      final List<CountryDetails> favorites = [];
      for (final code in favoriteCodes) {
        try {
          final country = await countriesRepository.getCountryDetails(code);
          favorites.add(country);
        } catch (e) {
          // TODO: Handle individual country fetch errors
        }
      }

      emit(FavoritesLoaded(favorites: favorites));
    } on Failure catch (failure) {
      emit(FavoritesError(failure.message));
    } catch (e) {
      emit(FavoritesError('Failed to refresh favorites: $e'));
    }
  }
}
