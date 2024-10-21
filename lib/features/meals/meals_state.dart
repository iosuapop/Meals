import 'package:meals/models/meal.dart';

class MealState{
  final List<Meal> meals;

  const MealState({this.meals = const []});


  List<Object> get props => [meals];
}
