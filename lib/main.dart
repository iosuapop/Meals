import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/features/categories/categories_bloc.dart';
import 'package:meals/features/categories/categories_event.dart';
import 'package:meals/features/favorite/favorite_bloc.dart';
import 'package:meals/features/filter/filter_bloc.dart';
import 'package:meals/features/filteredmeals/filteredmeals_bloc.dart';
import 'package:meals/features/meals/meals_bloc.dart';
import 'package:meals/features/meals/meals_event.dart';
import 'package:meals/features/tab/tab_bloc.dart';
import 'package:meals/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MealBloc()..add(const LoadMeals())),
          BlocProvider(create: (context) => FiltersBloc()),
          BlocProvider(create: (context) => CategoryBloc()..add(const LoadCategories())),
          BlocProvider(create: (context) => FilteredMealsBloc(mealBloc: context.read<MealBloc>(), filtersBloc: context.read<FiltersBloc>())),
          BlocProvider(create: (context) => FavoriteMealsBloc()),
          BlocProvider(create: (context) => TabBloc()),
        ],
        child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}