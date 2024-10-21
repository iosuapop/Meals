import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/favorite/favorite_bloc.dart';
import 'package:meals/features/favorite/favorite_state.dart';
import 'package:meals/features/filteredmeals/filteredmeals_bloc.dart';
import 'package:meals/features/filteredmeals/filteredmeals_state.dart';
import 'package:meals/features/mealscreen/mealsscreen_bloc.dart';
import 'package:meals/features/mealscreen/mealsscreen_event.dart';
import 'package:meals/features/tab/tab_bloc.dart';
import 'package:meals/features/tab/tab_event.dart';
import 'package:meals/features/tab/tab_state.dart';
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
        title: BlocBuilder<TabBloc, TabState>(
          builder: (context, state) {
            return Text(
              state.selectedTabIndex == 0 ? 'Categories' : 'Your Favorites',
            );
          },
        ),
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();
          if(identifier == 'filters'){
          Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ));
          }
        },
      ),
      body: BlocBuilder<TabBloc, TabState>(builder: (context, state) {
        if (state.selectedTabIndex == 0) {
          return BlocBuilder<FilteredMealsBloc, FilteredMealsState>(
              builder: (context, filteredMealsState) {
                return const CategoriesScreen();
              },
            );
        } else {
          return BlocBuilder<FavoriteMealsBloc, FavoriteMealsState>(
              builder: (context, favoriteMealsState) {
                final favoriteMeals = favoriteMealsState.favoriteMeals;
                return BlocProvider(
      create: (context) => MealsScreenBloc()
        ..add(LoadFavorites(meals: favoriteMeals)),
      child: const MealsScreen(),);
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
