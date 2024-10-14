import 'package:equatable/equatable.dart';
import 'package:meals/models/meal.dart';

abstract class FavoriteEvent extends Equatable{
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class ToggleFavoriteMeal extends FavoriteEvent{
  final Meal meal;
  
  const ToggleFavoriteMeal(this.meal);

  @override
  List<Object?> get props => [meal];
}


