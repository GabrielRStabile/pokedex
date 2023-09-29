import 'package:pokedex_app/shared/domain/entities/pokemon_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class HomeSuccess extends HomeState {
  final List<PokemonEntity> pokemons;

  HomeSuccess(this.pokemons);
}
