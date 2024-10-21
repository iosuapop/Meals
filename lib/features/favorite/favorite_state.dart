import 'package:meals/models/meal.dart';

class FavoriteMealsState{
  final List<Meal> favoriteMeals;

  const FavoriteMealsState({this.favoriteMeals = const []});


  List<Object> get props => [favoriteMeals];
}
