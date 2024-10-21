import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

abstract class MealsScreenEvent {
  const MealsScreenEvent();
}

class LoadMeals extends MealsScreenEvent {
  final String title;
  final Category category;
  final List<Meal> meals;

  const LoadMeals({required this.title, required this.category, this.meals = const []});
}

class LoadFavorites extends MealsScreenEvent {
  final List<Meal> meals;

  const LoadFavorites({this.meals = const []});
}


