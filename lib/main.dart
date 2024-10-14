import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:meals/features/Categories/categories_bloc.dart';
import 'package:meals/features/Tab/tab_bloc.dart';
import 'package:meals/features/tab/favorite/favorite_bloc.dart';
import 'package:meals/features/tab/filter/filter_bloc.dart';
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
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TabBloc()),
          BlocProvider(create: (context) => FavoriteBloc()),
          BlocProvider(create: (context) => FilterBloc()),
          BlocProvider(create: (context) => CategoriesBloc()),
        ],
        child: const TabsScreen()),
    );
  }
}