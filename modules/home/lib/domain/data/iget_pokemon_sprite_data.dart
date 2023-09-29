class GetPokemonSpritRequest {
  final String name;

  GetPokemonSpritRequest({
    required this.name,
  });
}

class GetPokemonSpritResponse {
  final String? image;

  GetPokemonSpritResponse({
    this.image,
  });
}

abstract class IGetPokemonSpritData {
  Future<GetPokemonSpritResponse> getSprite(
    GetPokemonSpritRequest params,
  );
}
