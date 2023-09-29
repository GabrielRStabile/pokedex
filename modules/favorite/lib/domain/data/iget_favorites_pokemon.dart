import 'package:pokedex_app/shared/domain/entities/pokemon_entity.dart';

class FavoritePokemonDTO {
  final String name;
  final String? imageUrl;

  FavoritePokemonDTO({
    required this.name,
    this.imageUrl,
  });

  PokemonEntity toEntity() => PokemonEntity(
        name: name,
        imageUrl: imageUrl,
      );
}

class GetFavoritesPokemonResponse {
  final List<FavoritePokemonDTO> pokemons;

  GetFavoritesPokemonResponse({
    required this.pokemons,
  });
}

abstract class IGetFavoritesPokemon {
  Future<GetFavoritesPokemonResponse> getFavorites();
}
