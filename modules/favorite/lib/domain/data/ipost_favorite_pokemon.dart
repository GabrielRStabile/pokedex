class PostFavoritePokemonRequest {
  final String name;
  final String? imageUrl;

  PostFavoritePokemonRequest({
    required this.name,
    this.imageUrl,
  });
}

abstract class IPostFavoritePokemon {
  Future<void> savePokemon(PostFavoritePokemonRequest params);
}
