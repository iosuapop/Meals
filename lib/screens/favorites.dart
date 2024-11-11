import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal/bloc/favorite/favorite_bloc.dart';
import 'package:meal/bloc/favorite/favorite_state.dart';
import 'package:meal/screens/meal_details.dart';
import 'package:meal/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteErrorState) {
          return Center(child: Text('Eroare: ${state.errorMessage}'));
        }

        if (state is FavoriteLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FavoriteLoadedState) {
          final favoriteMeals = state.favoriteMeals;

          if (favoriteMeals.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Uh oh ... nothing here',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Try adding some favorites',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: favoriteMeals.length,
            itemBuilder: (ctx, index) => MealItem(
              meal: favoriteMeals[index],
              onSelectMeal: (meal) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider.value(
                      value: BlocProvider.of<FavoriteBloc>(context),
                      child: MealDetailsScreen(meal: meal),
                    ),
                  ),
                );
              },
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
