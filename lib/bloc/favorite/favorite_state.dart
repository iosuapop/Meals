import 'package:equatable/equatable.dart';
import 'package:meal/models/meal.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteLoadedState extends FavoriteState {
  final List<Meal> favoriteMeals;

  const FavoriteLoadedState(this.favoriteMeals);

  @override
  List<Object?> get props => [favoriteMeals];
}

class FavoriteErrorState extends FavoriteState {
  final String errorMessage;

  const FavoriteErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
