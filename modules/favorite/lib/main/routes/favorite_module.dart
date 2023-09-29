import 'package:favorite/domain/data/idelete_favorite_pokemon.dart';
import 'package:favorite/domain/data/iget_favorites_pokemon.dart';
import 'package:favorite/domain/data/ipost_favorite_pokemon.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../infra/hive_favorite_repository.dart';
import '../../view/cubits/favorite_cubit.dart';
import '../../view/pages/favorites_pokemons_page.dart';

class FavoriteModule extends Module {
  @override
  void exportedBinds(i) {
    //Repositories
    i.add<IGetFavoritesPokemon>(HiveFavoriteRepository.new);
    i.add<IPostFavoritePokemon>(HiveFavoriteRepository.new);
    i.add<IDeleteFavoritePokemon>(HiveFavoriteRepository.new);

    //Cubits
    i.addSingleton<FavoriteCubit>(FavoriteCubit.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => FavoritesPokemonsPage());
  }
}
