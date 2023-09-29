import 'package:favorite/main/routes/favorite_module.dart';
import 'package:home/view/pages/home_page.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../domain/data/iget_pokemon_list_data.dart';
import '../../domain/data/iget_pokemon_sprite_data.dart';
import '../../infra/poke_api_provider.dart';
import '../../view/cubits/home/home_cubit.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [FavoriteModule()];

  @override
  void binds(i) {
    //Providers
    i.add<IGetPokemonListData>(PokeApiProvider.new);
    i.add<IGetPokemonSpritData>(PokeApiProvider.new);

    //Cubits
    i.addSingleton<HomeCubit>(HomeCubit.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => HomePage());
  }
}
