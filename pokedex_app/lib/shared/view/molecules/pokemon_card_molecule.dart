import 'package:favorite/view/cubits/favorite_cubit.dart';
import 'package:favorite/view/cubits/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../atoms/favorite_button_atom.dart';

class PokemonCardOrganism extends StatefulWidget {
  final PokemonEntity pokemon;

  const PokemonCardOrganism({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  State<PokemonCardOrganism> createState() => _PokemonCardOrganismState();
}

class _PokemonCardOrganismState extends State<PokemonCardOrganism> {
  final _favoriteCubit = Modular.get<FavoriteCubit>();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Image.network(
                  widget.pokemon.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.pokemon.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            BlocBuilder<FavoriteCubit, FavoriteState>(
              bloc: _favoriteCubit,
              builder: (_, state) {
                bool isFavorite = false;
                if (state is FavoriteSuccess) {
                  isFavorite = state.pokemons.any(
                    (pokemon) => pokemon.name == widget.pokemon.name,
                  );
                }

                return FavoriteButtonAtom(
                  filled: isFavorite,
                  onTap: () => _favoriteCubit.toggleFavorite(
                    name: widget.pokemon.name,
                    imageUrl: widget.pokemon.imageUrl,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
