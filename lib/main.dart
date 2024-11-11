import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:meal/bloc/favorite/favorite_bloc.dart';
import 'package:meal/bloc/favorite/favorite_event.dart';
import 'package:meal/bloc/favorite/favorite_service.dart';
import 'package:meal/bloc/filter/filter_bloc.dart';
import 'package:meal/bloc/filter/filter_event.dart';
import 'package:meal/bloc/tab/tab_bloc.dart';
import 'package:meal/bloc/tab/tab_event.dart';
import 'package:meal/bloc/tab/tab_service.dart';
import 'package:meal/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteBloc>(
          create: (context) { 
            final favoriteService = FavoriteService(firestore);
            return FavoriteBloc(favoriteService)..add(LoadFavoritesEvent());
          }
        ),
        BlocProvider<FiltersBloc>(
          create: (context) => FiltersBloc(firestore)..add(FetchFiltersEvent()),
        ),
        BlocProvider<TabBloc>(
          create: (context) { 
            final tabService = TabService(firestore);
            return TabBloc(BlocProvider.of<FiltersBloc>(context), tabService)..add(FetchDataEvent());
          }
        ),
      ],
      child: const TabsScreen(),
    ));
  }
}