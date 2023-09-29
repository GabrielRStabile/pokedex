class DeleteFavoritePokemonRequest {
  final String name;

  DeleteFavoritePokemonRequest({
    required this.name,
  });
}

abstract class IDeleteFavoritePokemon {
  Future<void> deletePokemon(DeleteFavoritePokemonRequest params);
}
