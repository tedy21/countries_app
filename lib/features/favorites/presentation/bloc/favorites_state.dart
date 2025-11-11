import 'package:equatable/equatable.dart';
import '../../../countries/domain/entities/country_details.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<CountryDetails> favorites;

  const FavoritesLoaded({required this.favorites});

  @override
  List<Object> get props => [favorites];

  FavoritesLoaded copyWith({
    List<CountryDetails>? favorites,
  }) {
    return FavoritesLoaded(
      favorites: favorites ?? this.favorites,
    );
  }
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}
