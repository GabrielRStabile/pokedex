import 'package:shared_dependencies/shared_dependencies.dart';

import '../../domain/data/idelete_favorite_pokemon.dart';
import '../../domain/data/iget_favorites_pokemon.dart';
import '../../domain/data/ipost_favorite_pokemon.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final _getFavoritesPokemonData = Modular.get<IGetFavoritesPokemon>();
  final _postFavoritePokemonData = Modular.get<IPostFavoritePokemon>();
  final _deleteFavoritePokemonData = Modular.get<IDeleteFavoritePokemon>();

  FavoriteCubit() : super(FavoriteInitial()) {
    getFavorites();
  }

  Future<void> getFavorites() async {
    try {
      emit(FavoriteLoading());

      final favorites = await _getFavoritesPokemonData.getFavorites();

      emit(FavoriteSuccess(favorites.pokemons));
    } on AppException catch (e) {
      emit(FavoriteError(e.message));
    } catch (e) {
      emit(
        FavoriteError(
          'Ops... não conseguimos carregar a lista de pokemons favoritos. Tente novamente.',
        ),
      );
    }
  }

  Future<void> toggleFavorite({required String name, String? imageUrl}) async {
    try {
      final request =
          PostFavoritePokemonRequest(name: name, imageUrl: imageUrl);

      if (state is FavoriteSuccess) {
        final currentState = state as FavoriteSuccess;

        if (currentState.pokemons.any((pokemon) => pokemon.name == name)) {
          _deleteFavoritePokemonData.deletePokemon(
            DeleteFavoritePokemonRequest(name: name),
          );
        } else {
          _postFavoritePokemonData.savePokemon(request);
        }
      } else {
        _postFavoritePokemonData.savePokemon(request);
      }

      getFavorites();
    } on AppException catch (e) {
      emit(FavoriteError(e.message));
    } catch (e) {
      emit(
        FavoriteError(
          'Ops... não conseguimos favoritar o pokemon. Tente novamente.',
        ),
      );
    }
  }
}
