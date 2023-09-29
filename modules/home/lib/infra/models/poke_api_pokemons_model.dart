import 'dart:convert';

class PokeApiPokemonsModel {
  final int count;
  final List<_Result> results;

  PokeApiPokemonsModel({
    required this.count,
    required this.results,
  });

  factory PokeApiPokemonsModel.fromJson(String str) =>
      PokeApiPokemonsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokeApiPokemonsModel.fromMap(Map<String, dynamic> json) =>
      PokeApiPokemonsModel(
        count: json["count"],
        results:
            List<_Result>.from(json["results"].map((x) => _Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class _Result {
  final String name;
  final String url;

  _Result({
    required this.name,
    required this.url,
  });

  factory _Result.fromMap(Map<String, dynamic> json) => _Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}
