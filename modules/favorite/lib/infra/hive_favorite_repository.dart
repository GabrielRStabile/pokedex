import 'package:hive/hive.dart';

import '../domain/data/idelete_favorite_pokemon.dart';
import '../domain/data/iget_favorites_pokemon.dart';
import '../domain/data/ipost_favorite_pokemon.dart';
import 'models/hive_favorite_pokemon_model.dart';

class HiveFavoriteRepository
    implements
        IGetFavoritesPokemon,
        IPostFavoritePokemon,
        IDeleteFavoritePokemon {
  static const boxName = 'favorites';

  static void registerAdapter() {
    Hive.registerAdapter(HiveFavoritePokemonModelAdapter());
  }

  @override
  Future<void> deletePokemon(DeleteFavoritePokemonRequest params) async {
    final favoriteBox = await Hive.openBox<HiveFavoritePokemonModel>(boxName);

    final index = favoriteBox.values
        .toList()
        .indexWhere((pokemon) => pokemon.name == params.name);

    await favoriteBox.deleteAt(index);
  }

  @override
  Future<GetFavoritesPokemonResponse> getFavorites() async {
    final favoriteBox = await Hive.openBox<HiveFavoritePokemonModel>(boxName);
    return GetFavoritesPokemonResponse(
      pokemons: favoriteBox.values.map((e) => e.toDTO()).toList(),
    );
  }

  @override
  Future<void> savePokemon(PostFavoritePokemonRequest params) async {
    final favoriteBox = await Hive.openBox<HiveFavoritePokemonModel>(boxName);
    await favoriteBox.add(HiveFavoritePokemonModel.fromPostRequest(params));
  }
}
