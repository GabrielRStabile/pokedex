import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../molecules/pokemon_card_molecule.dart';

class PokemonsGridOrganism extends StatelessWidget {
  final List<PokemonEntity> pokemons;

  const PokemonsGridOrganism({
    Key? key,
    required this.pokemons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 600;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pokemons.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 2 : 1,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (_, index) {
        final pokemon = pokemons[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PokemonCardOrganism(
            pokemon: pokemon,
          ),
        );
      },
    );
  }
}
