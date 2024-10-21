import 'package:meals/models/meal.dart';

abstract class MealDetailsEvent {
  const MealDetailsEvent();
}

class LoadMealDetails extends MealDetailsEvent {
  final Meal meal;

  const LoadMealDetails({required this.meal});
}
