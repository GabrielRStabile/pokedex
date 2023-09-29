import 'package:hive/hive.dart';

import '../../domain/data/iget_favorites_pokemon.dart';
import '../../domain/data/ipost_favorite_pokemon.dart';

part 'hive_favorite_pokemon_model.g.dart';

@HiveType(typeId: 1)
class HiveFavoritePokemonModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? imageUrl;

  HiveFavoritePokemonModel({
    required this.name,
    this.imageUrl,
  });

  factory HiveFavoritePokemonModel.fromPostRequest(
      PostFavoritePokemonRequest request) {
    return HiveFavoritePokemonModel(
      name: request.name,
      imageUrl: request.imageUrl,
    );
  }

  FavoritePokemonDTO toDTO() {
    return FavoritePokemonDTO(
      name: name,
      imageUrl: imageUrl,
    );
  }
}
