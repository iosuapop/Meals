import 'package:flutter/material.dart';
import 'package:meals/features/favorite/favorite_state.dart';
import 'package:meals/features/mealscreen/mealsscreen_bloc.dart';
import 'package:meals/features/mealscreen/mealsscreen_event.dart';
import 'package:meals/features/mealsdetails/mealsdetails_bloc.dart';
import 'package:meals/features/mealsdetails/mealsdetails_event.dart';
import 'package:meals/features/mealsdetails/mealsdetails_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/favorite/favorite_bloc.dart';
import 'package:meals/features/favorite/favorite_event.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealDetailsBloc, MealDetailsState>(
      builder: (context, mealDetailsState) {
        final meal = mealDetailsState.meal;

        if (meal == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return BlocConsumer<FavoriteMealsBloc, FavoriteMealsState>(
          listener: (context, state) {
            final isFavorite = state.favoriteMeals.contains(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(isFavorite
                    ? 'Meal added as a favorite'
                    : 'Meal removed from favorites'),
              ),
            );
            if(!isFavorite){
              final mealsScreenBloc = context.read<MealsScreenBloc>();
                  final mealsState = mealsScreenBloc.state.meals;
            context.read<MealsScreenBloc>().add(LoadFavorites(meals: mealsState));
            }
          },
          builder: (context, state) {
            final isFavorite = state.favoriteMeals.contains(meal);

            return Scaffold(
              appBar: AppBar(
                title: Text(meal.title),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<FavoriteMealsBloc>().add(ToggleFavoriteMeal(meal));
                    },
                    icon: isFavorite
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_border),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      meal.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Ingredients',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 14),
                    for (final ingredient in meal.ingredients)
                      Text(
                        ingredient,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    const SizedBox(height: 24),
                    Text(
                      'Steps',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 14),
                    for (final step in meal.steps)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          step,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
