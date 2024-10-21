import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/favorite/favorite_bloc.dart';
import 'package:meals/features/favorite/favorite_state.dart';
import 'package:meals/features/filteredmeals/filteredmeals_bloc.dart';
import 'package:meals/features/filteredmeals/filteredmeals_state.dart';
import 'package:meals/features/tab/tab_bloc.dart';
import 'package:meals/features/tab/tab_event.dart';
import 'package:meals/features/tab/tab_state.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  void _setScreen(BuildContext context, String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TabBloc, TabState>(
          builder: (context, state) {
            return Text(
              state.selectedTabIndex == 0 ? 'Categories' : 'Your Favorites',
            );
          },
        ),
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) => _setScreen(context, identifier),
      ),
      body: BlocBuilder<TabBloc, TabState>(builder: (context, state) {
        if (state.selectedTabIndex == 0) {
          return BlocBuilder<FilteredMealsBloc, FilteredMealsState>(
              builder: (context, filteredMealsState) {
                print(filteredMealsState.filteredMeals);
                return const CategoriesScreen();
              },
            );
        } else {
          return BlocBuilder<FavoriteMealsBloc, FavoriteMealsState>(
              builder: (context, favoriteMealsState) {
                print(favoriteMealsState.favoriteMeals);
                return MealsScreen(meals: favoriteMealsState.favoriteMeals);
              },
            );
        }
      }),
      bottomNavigationBar:
          BlocBuilder<TabBloc, TabState>(builder: (context, state) {
        return BottomNavigationBar(
          onTap: (index) {
            context.read<TabBloc>().add(TabChanged(index));
          },
          currentIndex: state.selectedTabIndex,
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
      }),
    );
  }
}
