import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealss/Categories/categories_event.dart';
import 'package:mealss/Categories/categories_state.dart';
import 'package:mealss/models/meal.dart';
import 'package:mealss/models/category.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final List<Meal> availableMeals;
  final List<Category> availableCategories;
  final void Function(Meal meal) onToggleFavorite;

  CategoriesBloc({
    required this.availableMeals,
    required this.availableCategories,
    required this.onToggleFavorite,
  }) : super(CategoriesInitialState()) {
    // Evenimentul de încărcare a categoriilor
    on<LoadCategoriesEvent>((event, emit) async {
      // Simulăm un delay pentru încărcare
      emit(CategoriesLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      // După încărcare, emitem starea cu categoriile disponibile
      emit(CategoriesLoadedState(availableCategories));
    });

    // Evenimentul de selecție a unei categorii
    on<SelectCategoryEvent>((event, emit) async {
      // Filtrăm mesele pe baza categoriei selectate
      final filteredMeals = availableMeals
          .where((meal) => meal.categories.contains(event.category.id))
          .toList();
      
      // Emităm starea cu mesele filtrate
      emit(MealsLoadedState(filteredMeals, event.category.title));

      await Future.delayed(const Duration(seconds: 2));

      emit(CategoriesLoadedState(availableCategories));
      
    });

    // Resetarea categoriilor
    on<ResetCategoriesEvent>((event, emit) {
      emit(CategoriesInitialState());
    });
  }
}
