import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_app/shared/view/organisms/pokemons_grid_organism.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../cubits/favorite_cubit.dart';
import '../cubits/favorite_state.dart';

class FavoritesPokemonsPage extends StatefulWidget {
  const FavoritesPokemonsPage({super.key});

  @override
  State<FavoritesPokemonsPage> createState() => _FavoritesPokemonsPageState();
}

class _FavoritesPokemonsPageState extends State<FavoritesPokemonsPage> {
  final _favoriteCubit = Modular.get<FavoriteCubit>();

  @override
  void initState() {
    super.initState();

    _favoriteCubit.getFavorites();

    _favoriteCubit.stream.listen(
      (state) {
        if (state is FavoriteError) {
          scheduleMicrotask(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seus Pokemons favoritos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              BlocBuilder<FavoriteCubit, FavoriteState>(
                bloc: _favoriteCubit,
                builder: (_, state) {
                  if (state is FavoriteSuccess) {
                    if (state.pokemons.isEmpty) {
                      return const Center(
                        child: Text('Você não tem nenhum pokemon favorito 😞'),
                      );
                    }
                    return PokemonsGridOrganism(
                      pokemons:
                          state.pokemons.map((e) => e.toEntity()).toList(),
                    );
                  } else if (state is FavoriteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
