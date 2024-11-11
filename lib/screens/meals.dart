import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal/bloc/favorite/favorite_bloc.dart';
import 'package:meal/bloc/tab/tab_bloc.dart';
import 'package:meal/bloc/tab/tab_state.dart';
import 'package:meal/screens/meal_details.dart';
import 'package:meal/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
      ),
      body: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          
          if (state is TabLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TabLoadedState) {
            final meals = state.meals;

            if (meals.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Uh oh ... nothing here',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Try selecting a different category',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (ctx, index) {
                final meal = meals[index];

                return MealItem(
                  meal: meal,
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
                );
              },
            );
          } else if (state is TabErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}
