import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/mealscreen/mealsscreen_bloc.dart';
import 'package:meals/features/mealscreen/mealsscreen_state.dart';
import 'package:meals/features/mealsdetails/mealsdetails_bloc.dart';
import 'package:meals/features/mealsdetails/mealsdetails_event.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsScreenBloc, MealsScreenState>(
      builder: (context, state) {
        var meals = state.meals;
        final title = state.title;

        Widget content = Center(
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
                'Try selecting a different category',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ],
          ),
        );

        if (meals.isNotEmpty) {
          content = ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider(
                      create: (ctx) => MealDetailsBloc()..add(LoadMealDetails(meal: meals[index])),
                      child: const MealDetailsScreen(),
                    ),
                  ),
                );
              },
            ),
          );
        }

        if (title == null) {
          return content;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: content,
        );
      },
    );
  }
}
