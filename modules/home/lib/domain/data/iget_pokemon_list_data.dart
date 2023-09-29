class GetPokemonListRequest {
  final int limit;
  final int offset;

  GetPokemonListRequest({
    required this.limit,
    required this.offset,
  });
}

class GetPokemonListResponse {
  final List<String> names;

  GetPokemonListResponse({
    required this.names,
  });
}

abstract class IGetPokemonListData {
  Future<GetPokemonListResponse> getPokemons(
    GetPokemonListRequest params,
  );
}
