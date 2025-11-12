import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/logger.dart';
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
      int failedCount = 0;
      bool hasNetworkError = false;

      for (final code in favoriteCodes) {
        try {
          final country = await countriesRepository.getCountryDetails(code);
          favorites.add(country);
        } on NetworkFailure catch (e) {
          hasNetworkError = true;
          failedCount++;
          Logger.warning(
              'Failed to load country details for $code (network): $e');
        } catch (e) {
          failedCount++;
          Logger.warning('Failed to load country details for $code: $e');
        }
      }

      if (favorites.isEmpty && failedCount > 0) {
        if (hasNetworkError) {
          emit(const FavoritesError(
            'No internet connection and no cached data available. Please check your connection.',
          ));
        } else {
          emit(const FavoritesError(
              'Failed to load favorites. Please try again.'));
        }
      } else {
        emit(FavoritesLoaded(
          favorites: favorites,
          hasPartialData: failedCount > 0,
          failedCount: failedCount > 0 ? failedCount : null,
        ));
      }
    } on Failure catch (failure) {
      emit(FavoritesError(failure.displayMessage));
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
        Logger.error('Failed to remove favorite: ${event.cca2}', e);
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
      int failedCount = 0;
      bool hasNetworkError = false;

      for (final code in favoriteCodes) {
        try {
          final country = await countriesRepository.getCountryDetails(code);
          favorites.add(country);
        } on NetworkFailure catch (e) {
          hasNetworkError = true;
          failedCount++;
          Logger.warning(
              'Failed to load country details for $code (network): $e');
        } catch (e) {
          failedCount++;
          Logger.warning('Failed to load country details for $code: $e');
        }
      }

      if (favorites.isEmpty && failedCount > 0) {
        if (hasNetworkError) {
          emit(const FavoritesError(
            'No internet connection and no cached data available. Please check your connection.',
          ));
        } else {
          emit(const FavoritesError(
              'Failed to refresh favorites. Please try again.'));
        }
      } else {
        emit(FavoritesLoaded(
          favorites: favorites,
          hasPartialData: failedCount > 0,
          failedCount: failedCount > 0 ? failedCount : null,
        ));
      }
    } on Failure catch (failure) {
      emit(FavoritesError(failure.displayMessage));
    } catch (e) {
      emit(FavoritesError('Failed to refresh favorites: $e'));
    }
  }
}
