import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/categories/categories_bloc.dart';
import 'package:meals/features/categories/categories_state.dart';
import 'package:meals/features/filteredmeals/filteredmeals_bloc.dart';
import 'package:meals/features/filteredmeals/filteredmeals_state.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, categoryState) {
      if (categoryState.categories.isEmpty) {
        print(categoryState.categories);
        return const Center(child: CircularProgressIndicator());
      }
      return BlocBuilder<FilteredMealsBloc, FilteredMealsState>(
          builder: (context, filteredMealsState) {
        final availableMeals = filteredMealsState.filteredMeals;
        print(categoryState.categories);
        return GridView(
          padding: const EdgeInsets.all(
            24,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in categoryState.categories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MealsScreen(
                        title: category.title,
                        meals: availableMeals,
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      });
    });
  }
}
