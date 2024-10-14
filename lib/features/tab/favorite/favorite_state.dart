import 'package:equatable/equatable.dart';
import 'package:meals/models/meal.dart';

class FavoriteState extends Equatable{
  const FavoriteState();

  @override
  List<Object?> get props => [];

  get favoriteMeals => [];
}

class FavoriteInitialState extends FavoriteState{
  @override
  List<Object?> get props => [];
}

class FavoriteUpdateState extends FavoriteState{
  final List<Meal> favoriteMeals;

  const FavoriteUpdateState(this.favoriteMeals);

  @override
  List<Object?> get props => [favoriteMeals];
}


