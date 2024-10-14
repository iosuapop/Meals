import 'package:mealss/models/category.dart';
import 'package:mealss/models/meal.dart';

abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final List<Category> availableCategories;
  CategoriesLoadedState(this.availableCategories);

  get filteredMeals => null;
}

// Stare pentru mesele filtrate
class MealsLoadedState extends CategoriesState {
  final List<Meal> filteredMeals;
  final String categoryTitle;
  MealsLoadedState(this.filteredMeals, this.categoryTitle);
}
