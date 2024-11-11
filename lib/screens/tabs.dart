import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal/bloc/filter/filter_bloc.dart';
import 'package:meal/bloc/tab/tab_bloc.dart';
import 'package:meal/bloc/tab/tab_event.dart';
import 'package:meal/bloc/tab/tab_state.dart';
import 'package:meal/screens/categories.dart';
import 'package:meal/screens/favorites.dart';
import 'package:meal/screens/filters.dart';
import 'package:meal/widgets/main_drawer.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (ctx, state) {
        if (state is TabInitialState || state is TabLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TabErrorState) {
          return Center(child: Text(state.errorMessage));
        } else if (state is TabLoadedState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.indexPage == 0 ? 'Categories' : 'Your Favorites',
              ),
            ),
            drawer: MainDrawer(
              onSelectScreen: (identifier) {
                Navigator.of(context).pop();
                if (identifier == 'filters') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => BlocProvider.value(
                        value: BlocProvider.of<FiltersBloc>(context),
                        child: const FiltersScreen(),
                      ),
                    ),
                  ).then((_) {
                    context.read<TabBloc>().add(FetchDataEvent());
                  });
                }
              },
            ),
            body: state.indexPage == 0 ? const CategoriesScreen() : const FavoritesScreen(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.indexPage,
              onTap: (index) {
                context.read<TabBloc>().add(ChangePageIndexEvent(index));
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
            ),
          );
        }
        return const Center(child: Text('Lucrăm la această eroare'));
      },
    );
  }
}
