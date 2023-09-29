import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_app/shared/view/atoms/favorite_button_atom.dart';
import 'package:pokedex_app/shared/view/organisms/pokemons_grid_organism.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../cubits/home/home_cubit.dart';
import '../cubits/home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeCubit = Modular.get<HomeCubit>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _homeCubit.getPokemonList();

    _homeCubit.stream.listen(
      (state) {
        if (state is HomeError) {
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

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _homeCubit.getPokemonList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Pokemons'),
        centerTitle: false,
        actions: [
          FavoriteButtonAtom(
            onTap: () {
              Modular.to.pushNamed('/favorite/');
            },
            filled: true,
          ),
          SizedBox(width: 16)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              BlocBuilder<HomeCubit, HomeState>(
                bloc: _homeCubit,
                builder: (_, state) {
                  if (state is HomeSuccess) {
                    return PokemonsGridOrganism(
                      pokemons: state.pokemons,
                    );
                  } else if (state is HomeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              BlocBuilder<HomeCubit, HomeState>(
                bloc: _homeCubit,
                builder: (_, state) {
                  if (state is! HomeLoading && state is! HomeError) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox.shrink();
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
