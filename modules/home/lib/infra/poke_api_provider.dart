import 'package:home/domain/data/iget_pokemon_list_data.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../domain/data/iget_pokemon_sprite_data.dart';
import 'models/poke_api_pokemon_model.dart';
import 'models/poke_api_pokemons_model.dart';

class PokeApiProvider implements IGetPokemonListData, IGetPokemonSpritData {
  final api = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'));

  @override
  Future<GetPokemonListResponse> getPokemons(
      GetPokemonListRequest params) async {
    final response = await api.get(
      'pokemon',
      queryParameters: {
        'limit': params.limit,
        'offset': params.offset,
      },
    );

    final data = PokeApiPokemonsModel.fromMap(response.data);

    final names = data.results.map((e) => e.name).toList();

    return GetPokemonListResponse(names: names);
  }

  @override
  Future<GetPokemonSpritResponse> getSprite(
      GetPokemonSpritRequest params) async {
    final response = await api.get('pokemon/${params.name}');

    final data = PokeApiPokemonModel.fromMap(response.data);

    return GetPokemonSpritResponse(
      image: data.sprites.frontDefault,
    );
  }
}
