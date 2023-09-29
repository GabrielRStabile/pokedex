import 'package:favorite/domain/data/iget_favorites_pokemon.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<FavoritePokemonDTO> pokemons;

  FavoriteSuccess(this.pokemons);
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}
