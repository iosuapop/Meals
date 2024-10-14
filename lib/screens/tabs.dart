import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/features/Tab/tab_bloc.dart';
import 'package:meals/features/Tab/tab_event.dart';
import 'package:meals/features/Tab/tab_state.dart';
import 'package:meals/features/tab/favorite/favorite_bloc.dart';
import 'package:meals/features/tab/favorite/favorite_event.dart';
import 'package:meals/features/tab/favorite/favorite_state.dart';
import 'package:meals/features/tab/filter/filter_bloc.dart';
import 'package:meals/features/tab/filter/filter_state.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TabBloc, TabState>(builder: (context, state) {
          return Text(
              state.selectedIndex == 0 ? 'Categories' : 'Your Favorites');
        }),
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          if (identifier == 'filters') {
            Navigator.of(context).pushNamed('/filters');
          }
        },
      ),
      body: BlocBuilder<TabBloc, TabState>(
        builder: (context, tabState) {
          return tabState.selectedIndex == 0
              ? BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, filterState) {
                    final availableMeals = dummyMeals.where((meal) {
                      if (filterState.selectedFilters[Filter.glutenFree]! &&
                          !meal.isGlutenFree) {
                        return false;
                      }
                      if (filterState.selectedFilters[Filter.lactoseFree]! &&
                          !meal.isLactoseFree) {
                        return false;
                      }
                      if (filterState.selectedFilters[Filter.vegetarian]! &&
                          !meal.isVegetarian) {
                        return false;
                      }
                      if (filterState.selectedFilters[Filter.vegan]! &&
                          !meal.isVegan) {
                        return false;
                      }
                      return true;
                    }).toList();

                    return CategoriesScreen(
                      // availableMeals: availableMeals,
                      // onToggleFavorite: (meal) {
                      //   context
                      //       .read<FavoriteBloc>()
                      //       .add(ToggleFavoriteMeal(meal));
                      // },
                    );
                  },
                )
              : BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, favoriteState) {
                    return MealsScreen(
                      meals: favoriteState.favoriteMeals,
                      onToggleFavorite: (meal) {
                        context
                            .read<FavoriteBloc>()
                            .add(ToggleFavoriteMeal(meal));
                      },
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<TabBloc>().add(TabChanged(index));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.set_meal),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favorites',
              ),
            ],
          );
        },
      ),
    );
  }
}