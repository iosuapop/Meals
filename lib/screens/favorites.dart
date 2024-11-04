import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_fb_bloc/bloc/favorite/favorite_bloc.dart';
import 'package:meals_fb_bloc/bloc/favorite/favorite_state.dart';
import 'package:meals_fb_bloc/models/meal.dart';
import 'package:meals_fb_bloc/screens/meal_details.dart';
import 'package:meals_fb_bloc/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  // void selectMeal(BuildContext context, Meal meal) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (ctx) => MealDetailsScreen(
  //         meal: meal,

  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        List<Meal> favoriteMeals = [];
        if (state is FavoriteLoadedState) {
          favoriteMeals = state.favoriteMeals;
        }
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
                const SizedBox(
                  height: 16,
                ),
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
        if (favoriteMeals.isNotEmpty) {
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
