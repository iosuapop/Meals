import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:meals/bloc/favorite/favorite_bloc.dart';
import 'package:meals/bloc/favorite/favorite_event.dart';
import 'package:meals/bloc/filter/filter_bloc.dart';
import 'package:meals/bloc/filter/filter_event.dart';
import 'package:meals/bloc/tab/tab_bloc.dart';
import 'package:meals/bloc/tab/tab_event.dart';
import 'package:meals/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc()..add(LoadFavoritesEvent()),
        ),
        BlocProvider<FiltersBloc>(
          create: (context) => FiltersBloc()..add(FetchFiltersEvent()),
        ),
        BlocProvider<TabBloc>(
          create: (context) => TabBloc(BlocProvider.of<FiltersBloc>(context))..add(FetchDataEvent()),
        ),
      ],
      child: const TabsScreen(),
    ));
  }
}