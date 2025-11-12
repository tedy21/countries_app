import 'package:equatable/equatable.dart';
import '../../../countries/domain/entities/country_details.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<CountryDetails> favorites;
  final bool hasPartialData;
  final int? failedCount;

  const FavoritesLoaded({
    required this.favorites,
    this.hasPartialData = false,
    this.failedCount,
  });

  @override
  List<Object?> get props => [favorites, hasPartialData, failedCount];

  FavoritesLoaded copyWith({
    List<CountryDetails>? favorites,
    bool? hasPartialData,
    int? failedCount,
  }) {
    return FavoritesLoaded(
      favorites: favorites ?? this.favorites,
      hasPartialData: hasPartialData ?? this.hasPartialData,
      failedCount: failedCount ?? this.failedCount,
    );
  }
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}
