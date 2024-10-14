import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  List<Meal> availableMeals = [];
  List<Category> availableCategories = [];
  void Function(Meal meal)? ontoggleFavorite;

  CategoriesBloc() : super(CategoriesLoadingState()) {
    on<LoadCategoriesEvent>((event, emit) {
      availableMeals = event.availableMeals;
      availableCategories = event.availableCategories;
      ontoggleFavorite = event.ontoggleFavorite;

      emit(CategoriesLoadedState(availableCategories));
    });

    on<SelectCategoryEvent>((event, emit) {
      final categoriesMeals = availableMeals
      .where((meal) => meal.categories.contains(event.category.id))
      .toList();

      emit(MealsLoadedState(event.category.title, categoriesMeals));
    });

    on<ToggleFavoriteMealEvent>((event, emit) {
      if(ontoggleFavorite != null) {
        ontoggleFavorite!(event.meal);
      }
    });
  }
}