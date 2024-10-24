import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class MealsScreenState {
  final String? title;
  final Category? category;
  final List<Meal> meals;

  const MealsScreenState({this.title, this.category,required this.meals});
}
