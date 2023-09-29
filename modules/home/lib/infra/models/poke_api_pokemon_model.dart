import 'dart:convert';

class PokeApiPokemonModel {
  final String name;
  final Sprites sprites;

  PokeApiPokemonModel({
    required this.name,
    required this.sprites,
  });

  factory PokeApiPokemonModel.fromJson(String str) =>
      PokeApiPokemonModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokeApiPokemonModel.fromMap(Map<String, dynamic> json) =>
      PokeApiPokemonModel(
        name: json["name"],
        sprites: Sprites.fromMap(json["sprites"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "sprites": sprites.toMap(),
      };
}

class Sprites {
  final String frontDefault;

  Sprites({
    required this.frontDefault,
  });

  factory Sprites.fromJson(String str) => Sprites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sprites.fromMap(Map<String, dynamic> json) => Sprites(
        frontDefault: json["front_default"],
      );

  Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
      };
}
