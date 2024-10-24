import 'package:meals/models/meal.dart';

abstract class FavoriteMealEvent{
  const FavoriteMealEvent();

  List<Object> get props => [];
}

class ToggleFavoriteMeal extends FavoriteMealEvent {
  final Meal meal;

  const ToggleFavoriteMeal(this.meal);

  @override
  List<Object> get props => [meal];
}
