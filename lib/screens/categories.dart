import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal/bloc/favorite/favorite_bloc.dart';
import 'package:meal/bloc/tab/tab_bloc.dart';
import 'package:meal/bloc/tab/tab_event.dart';
import 'package:meal/bloc/tab/tab_state.dart';
import 'package:meal/screens/meals.dart';
import 'package:meal/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(builder: (context, state) {
      if (state is TabLoadedState) {
        final categories = state.categories;

        return GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in categories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () async {
                  context.read<TabBloc>().add(FilterMealsByCategoryEvent(category.id));
                  
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: BlocProvider.of<TabBloc>(context)),
                        BlocProvider.value(value: BlocProvider.of<FavoriteBloc>(context)),
                      ],
                      child: const MealsScreen(),
                    ),
                  ));
                },
              ),
          ],
        );
      } else if (state is TabErrorState) {
        return Center(
          child: Text('Eroare: ${state.errorMessage}'),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
