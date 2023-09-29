import 'package:home/view/cubits/home/home_state.dart';
import 'package:pokedex_app/shared/domain/entities/pokemon_entity.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../domain/data/iget_pokemon_list_data.dart';
import '../../../domain/data/iget_pokemon_sprite_data.dart';

class HomeCubit extends Cubit<HomeState> {
  final _getPokemonListData = Modular.get<IGetPokemonListData>();
  final _getPokemonSpriteData = Modular.get<IGetPokemonSpritData>();

  int _offset = 0;
  final int _limit = 20;
  final List<PokemonEntity> _pokemons = [];
  bool _isFetching = false;

  HomeCubit() : super(HomeInitial());

  Future<void> getPokemonList() async {
    try {
      if (_isFetching) return;

      _isFetching = true;
      if (_pokemons.isEmpty) emit(HomeLoading());

      final pokemonList = await _getPokemonListData
          .getPokemons(GetPokemonListRequest(limit: _limit, offset: _offset));

      List<Future<GetPokemonSpritResponse>> spriteRequests = [];

      for (var pokemon in pokemonList.names) {
        spriteRequests.add(
          _getPokemonSpriteData.getSprite(
            GetPokemonSpritRequest(name: pokemon),
          ),
        );
      }

      final sprites = await Future.wait(spriteRequests);

      for (var i = 0; i < pokemonList.names.length; i++) {
        _pokemons.add(
          PokemonEntity(
            name: pokemonList.names[i],
            imageUrl: sprites[i].image,
          ),
        );
      }

      _offset += _limit;

      emit(HomeSuccess(_pokemons));
    } on AppException catch (e) {
      emit(HomeError(e.message));
    } catch (e) {
      emit(
        HomeError(
            'Ops... não conseguimos carregar a lista de pokemons. Tente novamente.'),
      );
    } finally {
      _isFetching = false;
    }
  }
}
