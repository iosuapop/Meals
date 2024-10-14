import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/Categories/categories_bloc.dart';
import 'package:meals/features/Categories/categories_event.dart';
import 'package:meals/features/Categories/categories_state.dart';
import 'package:meals/features/tab/favorite/favorite_bloc.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Categories'),),
    body: BlocListener<CategoriesBloc, CategoriesState>(
          listener: (ctx, state) {
            if (state is MealsLoadedState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider.value(
                      value: BlocProvider.of<FavoriteBloc>(context),
                      child: MealsScreen(
                      title: state.categoryTitle,
                      meals: state.filteredMeals,
                      onToggleFavorite: (meal) {
                        // BlocProvider.of<FavoriteBloc>(context).add(ToggleFavoriteMealEvent(meal));
                      },
                      ),
                    ),
                    ),
                  );
            }
          },
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (ctx, state) {
              if (state is CategoriesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } 
              else 
              if (state is CategoriesLoadedState) {
                return GridView(
                  padding: const EdgeInsets.all(24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  children: [
                    for (final category in state.availableCategories)
                      CategoryGridItem(
                        category: category,
                        onSelectCategory: () {
                          BlocProvider.of<CategoriesBloc>(ctx)
                              .add(SelectCategoryEvent(category));
                        },
                      ),
                  ],
                );
              } else{
                print(state);
                return const Center(child: Text("An error has occured!",),);
              }
            },
          ),
        ),
      );
}

}
